class CandyWrapPaperUploader < Shrine
  plugin :default_storage, cache: :candy_wrap_cache, store: :candy_wrap_store
  plugin :activerecord
  plugin :derivatives

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      large: magick.resize_to_limit!(800, 800),
      small: magick.resize_to_limit!(300, 300),
    }
  end
end
