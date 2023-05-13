class UsersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    user = find_user
    render json: user, include: :items
  end

  private

  def find_user
    User.find(params[:id])
  end

  def not_found
    render json: { error: "User not found" }, status: :not_found
  end

end
