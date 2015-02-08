require "sinatra"

avatar_path = "public/images/avatars/"
avatar_files = Dir["#{avatar_path}*.{gif,jpeg,png}"]

sig_path = "public/images/sigs/"
sig_files = Dir["#{sig_path}*.{gif,jpeg,png}"]

get "/avatar.gif" do
  file = avatar_files.sample

  headers \
    "Cache-Control" => "no-cache, private",
    "Pragma"        => "no-cache",
    "Content-type"  => "multipart/x-mixed-replace; boundary=#{boundary}"

  content_type "image/gif"
  File.read(file)
end

get "/sig.gif" do
  file = sig_files.sample

  headers \
    "Cache-Control" => "no-cache, private",
    "Pragma"        => "no-cache",
    "Content-type"  => "multipart/x-mixed-replace; boundary=#{boundary}"

  content_type "image/gif"
  File.read(file)
end
