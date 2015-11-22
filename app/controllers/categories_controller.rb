class CategoriesController < ApplicationController
  before_action :require_user, only: [:create]
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "New Category created"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    # binding.pry
  end

  
  private

  def category_params
    params.require(:category).permit(:name)
  end
end