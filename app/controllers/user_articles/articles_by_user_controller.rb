module UserArticles

  class ArticlesByUserController < ApplicationController

    def index
      @articles = current_user.articles.paginate( page: params[:page], :per_page => 10)
    end
    
  end

end
