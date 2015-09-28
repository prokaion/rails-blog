require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @article = @user.articles.build(title: "Lorem", text: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    assert @article.valid?
  end

  test "user id should be present" do
    @article.user_id = nil
    assert_not @article.valid?
  end

  test "content should be present" do
    @article.text = "   "
    assert_not @article.valid?
  end

  test "content should be at most 10000 characters" do
    @article.text = "a" * 10001
    assert_not @article.valid?
  end

  test "content should be at least 3 characters" do
    @article.text = "a"
    assert_not @article.valid?
  end

  test "order should be most recent first" do
    assert_equal articles(:most_recent), Article.first
  end


end
