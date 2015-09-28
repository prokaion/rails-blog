require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  def setup
    @article = articles(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Article.count' do
      post :create, article: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Article.count' do
      delete :destroy, id: @article
    end
    assert_redirected_to login_url
  end
end
