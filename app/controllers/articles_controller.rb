class ArticlesController < ApplicationController
  before_action :logged_in_user,        only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user_or_admin, only: [:edit, :update, :destroy]
  
  def articles_by_user
    # careful! might be more than one user!
    @userToShow = User.find_by(name: params[:username])
    @articles = @userToShow.articles
    #show only published articles if guest or not owner and not admin!
    if( current_user == nil || @user != current_user && !current_user.admin?)      
      @articles = remove_unpublished_articles(@articles)
    end
  end

	def index
    if (user_param_and_current_user_present && params[:user] == current_user.id.to_s)
      @user = current_user
      @articles = current_user.articles
    else
      @articles = Article.all
    end
    #show only published articles if guest or not owner and not admin!
    if( current_user == nil || @user != current_user && !current_user.admin?)      
      @articles = remove_unpublished_articles(@articles)
    end
	end
	
	def show
    @article = Article.find(params[:id])
    puts @article.categories.map{|cat| cat.id}
  end

	def new
		@article = Article.new
	end
	
	def edit
	  @article = Article.find(params[:id])
    @chosen_cats = @article.categories.map{ |cat| cat.id }
	end	
	
	def create
	  @article = current_user.articles.build(article_params)
 
    add_remove_categories(params[:article][:categories])
    
	  if @article.save
      flash[:success] = "Article created!"
		  redirect_to @article
	  else
		  render 'new'
	  end	
	end
  
	def update
	  @article = Article.find(params[:id])
    
    add_remove_categories(params[:article][:categories])

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
	    params.require(:article).permit(:categories, :title, :text, :published)
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

    def add_remove_categories(category_params)
      selected_category_ids = []

      if( category_params != nil )
        selected_category_ids = category_params.map(&:to_i)
      end

      # 1) check for any differences in article.categories and selected_category_ids
      if( selected_category_ids.sort != @article.category_ids.sort)

        # 2) get all categories and remove all which are not in selected_category_ids
        categories = Category.all.to_a
        
        categories.keep_if { |category| selected_category_ids.include?(category.id) }
        
        @article.categories=(categories)
      end 
    end
end
