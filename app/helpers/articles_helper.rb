module ArticlesHelper

  def remove_unpublished_articles(articles)          
    articles = articles.to_a
    articles.delete_if { |article| article.published == false }
  end

end
