class ArticlesController < ApplicationController
  before_action :logged_in_user,        only: [:create, :edit, :update, :destroy]
  before_action :correct_user_or_admin, only: [:edit, :update, :destroy]

	def index
    if (user_param_and_current_user_present && params[:user] == current_user.id.to_s)
      @user = current_user
      @articles = current_user.articles
    else
		  @articles = Article.all
    end
	end
	
	def show
    @article = Article.find(params[:id])
  end

	def new
		@article = Article.new
	end
	
	def edit
	  @article = Article.find(params[:id])
	end	
	
	def create
	  @article = current_user.articles.build(article_params)
 
	  if @article.save
      flash[:success] = "Article created!"
		  redirect_to @article
	  else
		  render 'new'
	  end	
	end
  
	def update
	  @article = Article.find(params[:id])
	 
	  if @article.update(article_params)
		  redirect_to @article
	  else
		  render 'edit'
	  end
	end
	
	def destroy
	  @article = Article.find(params[:id])
	  @article.destroy
	  flash[:success] = "Article destroyed!"
	  redirect_to articles_path
	end

	private
	  def article_params
	    params.require(:article).permit(:title, :text)
	  end

    def user_param_and_current_user_present
      params[:user] != nil && current_user
    end

    def correct_user_or_admin
      @article = Article.find(params[:id])
      if(current_user != @article.user && !current_user.admin?)
        flash[:danger] = "You dont have permissions to do that!"
        redirect_to @article
      end
    end
end
