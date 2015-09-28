require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @article = @user.articles.build(title: "Lorem", text: "Lorem ipsum", user_id: @user.id)
    @comment = @article.comments.build(commenter: "Hans", body: "bla", article_id: @article_id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "commenter should be present" do
    @comment.commenter = nil
    assert_not @comment.valid?
  end

  test "body should be present" do
    @comment.body = ""
    assert_not @comment.valid?
  end

  test "body should have mininum length" do
    @comment.body = "B"
    assert_not @comment.valid?
  end

  test "body should not exceed maximum length" do
    @comment.body = "B" * 10001
    assert_not @comment.valid?
  end

  test "order should be most recent first" do
    assert_equal comments(:most_recent), Comment.first
  end
end
