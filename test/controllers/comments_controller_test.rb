require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:spiderman)
    log_in_as(@user)
  end

  test "should redirect when not logged in" do
    log_out
    poem = poems(:oath)
    post poem_comments_url(poem), params: { comment: { content: "Great poem!", start_position: 0, end_position: 10 } }
    assert_redirected_to login_url
  end

  test "should create comment when logged in and redirected to poem" do
    poem = poems(:oath)
    assert_difference("Comment.count") do
      post poem_comments_url(poem), params: { comment: { content: "Great poem!", start_position: 0, end_position: 10 } }
    end
    assert_redirected_to poem_url(poem)
  end
end
