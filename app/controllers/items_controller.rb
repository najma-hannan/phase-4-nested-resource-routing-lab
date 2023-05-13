class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    if params[:user_id]
      user = find_user
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = find_item
    render json: item, include: :user
  end

  def create
    user = find_user
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:user_id, :name, :description, :price)
  end

  def find_item
    Item.find(params[:id])
  end

  def find_user
    User.find(params[:user_id])
  end

  def not_found(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end

end
