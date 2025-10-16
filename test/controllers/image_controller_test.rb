require "test_helper"

class ImageControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = images(:image_one)
    @image.image_file.attach(fixture_file_upload("test.png", "image/png"))
    @user = users(:spiderman)
    log_in_as(@user)
  end

  test "should redirect if not logged in" do
    log_out
    get images_url
    assert_redirected_to login_url
  end

  test "should get index" do
    get images_url
    assert_response :success
  end

  test "should show image" do
    get image_url(@image)
    assert_response :success
  end

  test "should create image" do
    assert_difference("Image.count") do
      post images_url, params: { image: { title: "New Image", image_file: fixture_file_upload("test.png", "image/png") } }
    end

    assert_redirected_to image_url(Image.last)
  end
end
