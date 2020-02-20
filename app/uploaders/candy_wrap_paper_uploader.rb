class CandyWrapPaperUploader < Shrine
  plugin :default_storage, cache: :candy_wrap_cache, store: :candy_wrap_store
  plugin :activerecord
end
