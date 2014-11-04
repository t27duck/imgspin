require "sinatra"

avatar_path = "images/avatars/"
avatar_files = Dir["#{avatar_path}*.{gif,jpeg,png}"]

sig_path = "images/sigs/"
sig_files = Dir["#{sig_path}*.{gif,jpeg,png}"]

get "/avatar.gif" do
  file = avatar_files.sample
  send_file file, :disposition => :inline
end

get "/sig.gif" do
  file = sig_files.sample
  send_file file, :disposition => :inline
end
