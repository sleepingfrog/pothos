require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"

s3_options = {
  access_key_id: ENV["S3_ACCESS_KEY"],
  secret_access_key: ENV["S3_SECRET_ACCESS_KEY"],
  bucket: "pothos",
  endpoint: ENV["S3_ENDPOINT"],
  force_path_style: true,
  region: "s3",
}

Shrine.storages = {
  candy_wrap_cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/candy_wrap/cache"),
  candy_wrap_store: Shrine::Storage::S3.new(prefix: "uploads/candy_wrap/store", **s3_options),
}
