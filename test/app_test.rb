# frozen_string_literal: true

require "test_helper"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  AVATAR_FILES = Dir["public/images/avatars/*.gif"]
  SIG_FILES = Dir["public/images/sigs/*.gif"]

  def app
    Sinatra::Application
  end

  def test_root
    get "/"

    assert last_response.ok?
    assert_equal "Hello", last_response.body
  end

  def test_health_check
    get "/up"

    assert last_response.ok?
    assert_equal "OK", last_response.body
  end

  def test_not_found
    get "/does-not-exist"

    assert_equal 404, last_response.status
    assert_equal "404-ed!", last_response.body
  end

  def test_image_directories_are_not_empty
    refute_empty AVATAR_FILES
    refute_empty SIG_FILES
  end

  def test_avatar_returns_a_gif_from_the_avatars_directory
    get "/avatar.gif"

    assert last_response.ok?
    assert_random_gif_response AVATAR_FILES
  end

  def test_sig_returns_a_gif_from_the_sigs_directory
    get "/sig.gif"

    assert last_response.ok?
    assert_random_gif_response SIG_FILES
  end

  private

  def assert_random_gif_response(files)
    assert_equal "image/gif", last_response.content_type
    assert_equal "no-cache, private", last_response.headers["cache-control"]
    assert_equal "no-cache", last_response.headers["pragma"]

    body = last_response.body.b
    assert files.any? { |f| File.binread(f) == body }, "response body did not match any file"
  end
end
