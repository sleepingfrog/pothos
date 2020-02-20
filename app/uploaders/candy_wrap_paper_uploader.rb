class CandyWrapPaperUploader < Shrine
  plugin :default_storage, cache: :candy_wrap_cache, store: :candy_wrap_store
  plugin :activerecord
  plugin :derivatives

  Attacher.derivatives do |original|
    case file.mime_type
    when "image/jpeg"
      process_derivatives(:image, original)
    when "application/pdf"
      process_derivatives(:pdf, original)
    end
  end

  Attacher.derivatives :image do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      large: magick.resize_to_limit!(800, 800),
      small: magick.resize_to_limit!(300, 300),
    }
  end

  Attacher.derivatives :pdf do |original|
    magick = ImageProcessing::MiniMagick.source(original).loader(page: 0).convert("jpg")

    {
      large: magick.resize_to_limit!(800, 800),
      small: magick.resize_to_limit!(300, 300),
    }
  end
end
