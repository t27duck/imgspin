# frozen_string_literal: true

require "sinatra"

avatar_path = "public/images/avatars/"
avatar_files = Dir["#{avatar_path}*.gif"]

sig_path = "public/images/sigs/"
sig_files = Dir["#{sig_path}*.gif"]

get "/" do
  "Hello"
end

get "/up" do
  "OK"
end

not_found do
  status 404
  "404-ed!"
end

get "/avatar.gif" do
  file = avatar_files.sample

  headers \
    "cache-control" => "no-cache, private",
    "pragma"        => "no-cache",
    "content-type"  => "multipart/x-mixed-replace"

  content_type "image/gif"
  File.read(file)
end

get "/sig.gif" do
  file = sig_files.sample

  headers \
    "cache-control" => "no-cache, private",
    "pragma"        => "no-cache",
    "content-type"  => "multipart/x-mixed-replace"

  content_type "image/gif"
  File.read(file)
end
