require "test_helper"

class PoemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @poem = poems(:oath)
    @user = users(:spiderman)
    log_in_as(@user)
  end

  test "should redirect when not logged in" do
    log_out
    get poems_url
    assert_redirected_to login_url
  end

  test "should get index" do
    get poems_url
    assert_response :success
  end

  test "should get new" do
    get new_poem_url
    assert_response :success
  end

  test "should create poem" do
    assert_difference("Poem.count") do
      post poems_url, params: { poem: { content: @poem.content, title: @poem.title } }
    end

    assert_redirected_to poem_url(Poem.last)
  end

  test "should show poem" do
    get poem_url(@poem)
    assert_response :success
  end
end
