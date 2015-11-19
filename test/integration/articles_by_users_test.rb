require 'test_helper'

class Artticles_By_User_Test < ActionDispatch::IntegrationTest
  def setup
    @controller = UserArticles::ArticlesByUserController.new
    @archer = users(:archer)
    @admin = users(:michael)
    @user = users(:lana)
  end

  test "should get index guest show only published articles" do
    #log_in_as(@archer)
    get "/users/950961012/articles_by_user"
    assert_response :success
    # assert only published articles are shown because guest user is calling url
    assert_select "span", {count: 0, text: "(Draft: unpublished)"}, "should not contain drafts!"
  end

  test "should get index owner show all articles" do
    log_in_as(@archer)
    get "/users/950961012/articles_by_user"
    assert_response :success
   
    assert_select "span", {count: 1, text: "(Draft: unpublished)"}, "should show drafts and published articles!"
  end

  test "should get index admin show all articles" do
    log_in_as(@admin)
    get "/users/950961012/articles_by_user"
    assert_response :success
    
    assert_select "span", {count: 1, text: "(Draft: unpublished)"}, "should show drafts and published articles!"
  end

  test "guest search articles show only published articles" do
    get "/user_articles?user_name=Archer"
    assert_response :success
    assert_select "span", {count: 0, text: "(Draft: unpublished)"}, "should not contain drafts!"
  end

  test "owner search articles show all articles" do
    log_in_as(@archer)
    get "/user_articles?user_name=Archer"
    assert_response :success
    assert_select "span", {count: 1, text: "(Draft: unpublished)"}, "should show drafts and published articles!"
  end

  test "admin search articles show all articles" do
    log_in_as(@admin)
    get "/user_articles?user_name=Archer"
    assert_response :success
    assert_select "span", {count: 1, text: "(Draft: unpublished)"}, "should show drafts and published articles!"
  end
end