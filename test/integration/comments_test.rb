require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  self.use_transactional_fixtures = true

  def setup
    @user       = users(:archer)
    @admin      = users(:michael)
    @article    = articles(:orange)
  end

  test "should not show comment-form if not logged in" do    
    get articles_path
    assert_select 'form#new_comment', count: 0
  end

  test "should show comment-form if logged in" do
    log_in_as(@user)
    get articles_path
    assert_select 'form#new_comment', count: Article.published(true).count
  end

  test "should be admin to see destroy link on comments" do
    log_in_as(@admin)
    get articles_path
    assert_select 'a', text: "Destroy Comment", count: comments.count
  end

  test "should be zero destroy links on comments if not admin" do
    get articles_path
    assert_select 'a', text: "Destroy Comment", count: 0
  end

  test "post valid comment" do
    log_in_as(@user)
    assert_difference 'Comment.count', 1 do
    post article_comments_path(@article), comment: {  commenter:  @user.name,
                                                      body:       "Lore Ipsum",
                                                      article_id: @article }
    end
  end

  test "post invalid comment no user" do
    log_in_as(@user)
    assert_difference 'Comment.count', 0 do
    post article_comments_path(@article), comment: {  commenter:  "",
                                                      body:       "Lore Ipsum",
                                                      article_id: @article }
    end
  end

  test "post invalid comment no body" do
    log_in_as(@user)
    assert_difference 'Comment.count', 0 do
    post article_comments_path(@article), comment: {  commenter:  @user.name,
                                                      body:       "",
                                                      article_id: @article }
    end
  end
end
