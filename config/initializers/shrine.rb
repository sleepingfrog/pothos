require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  candy_wrap_cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/candy_wrap/cache"),
  candy_wrap_store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/candy_wrap/store"),
}
