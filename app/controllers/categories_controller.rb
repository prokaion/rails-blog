class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Category created!"
      redirect_to @category
    else
      render 'new'
    end 
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      flash[:success] = "Category updated!"
      redirect_to @category
    else
      render 'edit'
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.all
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:success] = "Category destroyed!"
    redirect_to categories_path
  end

  private
    def category_params
      params.require(:category).permit(:cat_name)
    end
end
