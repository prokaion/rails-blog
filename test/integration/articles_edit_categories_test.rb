#articles_edit_test

require 'test_helper'

class ArtticlesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:archer)
    @article = articles(:orange)
    @categories = [categories(:cat_one).id]
  end

  test "add_category" do
    log_in_as(@user)
    get edit_article_path(@article)
    assert_empty( @article.categories, "categories should be empty" )

    assert_template 'articles/edit'
    patch article_path(@article), article: { title:  "blub",
                                    text: "bla@gmail.com",
                                    categories: @categories }

    puts @request.params

    @article.reload
    puts @article.categories.to_s

    assert_same( categories(:cat_one).id, @article.categories[0].id )
  end

  test "add_two_categories_where_one_of_them_is already_in_article_should_result_with_no_error" do
    # add first cat to article
    @article.categories = [categories(:cat_one)]
    @article.save
    @article.reload
    assert_same( categories(:cat_one).id, @article.categories[0].id )

    # prepare the param-list for the two categories
    category_ids = @categories << categories(:cat_two).id
    puts category_ids.to_s

    # start test
    log_in_as(@user)
    get edit_article_path(@article)
    patch article_path(@article), article: { title:  "blub",
                                    text: "bla@gmail.com",
                                    categories: category_ids }

    @article.reload
    assert_equal( category_ids.sort, @article.categories.map{|cat| cat.id}.sort )                                      
  end

  test "given_an_article_with_two_cats_and_only_one_seleted_in_form_should_remove_the_one_which_wasnt_selected" do
    @article.categories = [categories(:cat_one), categories(:cat_two)]
    @article.save
    @article.reload
    assert_same(2, @article.categories.count)

    category_ids = [categories(:cat_two).id]

    # start test
    log_in_as(@user)
    get edit_article_path(@article)
    patch article_path(@article), article: { title:  "blub",
                                    text: "bla@gmail.com",
                                    categories: category_ids }

    puts @request.params
                                  
    @article.reload
    assert_same(1, @article.categories.count)
  end

  # the following tests something like the all categories or no categories
  test "nothing_was_selected_results_in_article_with_no_categories" do
    @article.categories = [categories(:cat_one), categories(:cat_two)]
    @article.save
    @article.reload
    assert_same(2, @article.categories.count)

    category_ids = []

    # start test
    log_in_as(@user)
    get edit_article_path(@article)
    patch article_path(@article), article: { title:  "blub",
                                    text: "bla@gmail.com",
                                    categories: category_ids }

    puts @request.params
                                  
    @article.reload
    assert_same(0, @article.categories.count)
  end

  test "what_happens_if_non_empty_category_is_deleted" do
    @article.categories = [categories(:cat_one), categories(:cat_two)]
    @article.save
    @article.reload
    assert_same(2, @article.categories.count)

    # start test
    assert_difference('Category.count', -1) do
      delete category_path(categories(:cat_two))
    end

    @article.reload
    assert_not_nil(@article, "article should still exist!")

    assert_same(1, @article.categories.count)
    assert_same(categories(:cat_one).id, @article.categories[0].id)
  end
end