module UserArticles

  class ArticlesByUserController < ApplicationController

    def index  
      @userToShow = params[:user_name].present? ? User.filter( filter_params(params) ) : User.find(params[:user_id])
        
      filtered_params = {}
      #show only published articles if guest or not owner and not admin!
      if( current_user == nil || @userToShow != current_user && !current_user.admin?)
        filtered_params[:published] = true 
      end
      @articles = @userToShow.articles.filter( filtered_params ).paginate( page: params[:page], :per_page => 10 )  
    
    end

    private
      def filter_params(params)
        params.slice(:user_name)
      end
    
  end


end
