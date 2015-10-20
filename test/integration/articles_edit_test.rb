#articles_edit_test

require 'test_helper'

class ArtticlesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:archer)
    @article = articles(:orange)
  end

  test "test_stuff" do
    log_in_as(@user)
    get edit_article_path(@article)
    assert_template 'articles/edit'
    patch article_path(@article), article: { title:  "blub",
                                    text: "bla@gmail.com" }

    puts @request.params.class
  end
end