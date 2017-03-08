class Api::V1::Users::AvatarController < ApplicationController
  def show
    render json: { thumb: @current_user.avatar.url(:thumb) }
  end

  def create
    @current_user.avatar=resource_params[:avatar]

    if @current_user.valid?
      @current_user.save!
      render json: { thumb: @current_user.avatar.url(:thumb) }
    else
      render json: @current_user.errors.to_json, status: :unprocessable_entity
    end
  end

  protected

  def resource_params
    params.permit(:avatar)
  end
end
