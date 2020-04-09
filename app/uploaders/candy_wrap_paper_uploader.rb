require "zip"

class CandyWrapPaperUploader < Shrine
  plugin :default_storage, cache: :candy_wrap_cache, store: :candy_wrap_store
  plugin :activerecord
  plugin :derivatives
  plugin :determine_mime_type, analyzer: :marcel
  plugin :validation
  plugin :validation_helpers

  Attacher.validate do
    validate_mime_type %w[image/jpeg application/pdf application/zip], message: "file type invalid"
  end

  Attacher.derivatives do |original|
    case file.mime_type
    when "image/jpeg"
      process_derivatives(:image, original)
    when "application/pdf"
      process_derivatives(:pdf, original)
    when "application/zip"
      process_derivatives(:zip, original)
    end
  end

  Attacher.derivatives :image do |original|
    magick = ImageProcessing::MiniMagick.source(original).convert('png')

    {
      large: magick.resize_to_limit!(800, 800),
      small: magick.resize_to_limit!(300, 300),
    }
  end

  Attacher.derivatives :pdf do |original|
    magick = ImageProcessing::MiniMagick.source(original).loader(page: 0).convert("png")

    {
      large: magick.resize_to_limit!(800, 800),
      small: magick.resize_to_limit!(300, 300),
    }
  end

  # expecting application/pdf
  Attacher.derivatives :zip do |original|
    result = nil
    Zip::File.open(original) do |zip|
      filename = zip.first.name
      Tempfile.open([File.basename(filename, ".*"), File.extname(filename)]) do |tmpfile|
        zip.first.extract(tmpfile.path) { true }

        magick = ImageProcessing::MiniMagick.source(tmpfile).loader(page: 0).convert("png")
        result = {
          large: magick.resize_to_limit!(800, 800),
          small: magick.resize_to_limit!(300, 300),
        }
      end
    end

    result
  end
end
