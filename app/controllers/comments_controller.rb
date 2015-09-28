class CommentsController < ApplicationController
  before_action :logged_in_user,        only: [:create]

  def index
    @article = Article.find(params[:article_id])
    redirect_to article_path(@article)
    #@comments = @article.comments.all   
  end

  def new
    @article = Article.find(params[:article_id])
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to article_path(@article)
    else
      render 'new'
    end   
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
