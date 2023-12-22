# module Api
class Api::UsersController < Api::ApiController
  # require 'will_paginate/array'
  # before_action :authenticate_api_user!
  before_action :set_user, only: %i[show update destroy]
  before_action :set_current_user, only: %i[index profile edit]

  def index
    @users = if params[:search].present?
               User.includes(:role).where('username LIKE :search OR email LIKE :search', search: "%#{params[:search]}%")
             else
               User.includes(:role).all.to_a
               # User.includes(:profile, :location, :social_links).all
             end
    if @users.any?
      # render json: @users, each_serializer: Users::UserSerializer, status: :ok
      # @users.paginate(page: params[:page] || 1, per_page: @items_per_page),
      @items_per_page = params[:per_page] || 10
      @total_page = (@users.count / @items_per_page.to_f).ceil
      render_success_response('Users fetched successfully', @users, total_page: @total_page)
    else
      render_not_found_response('No users fozzzund with the given search criteria.')
    end
  end

  def show
    render json: @user, serializer: Users::UserSerializer, status: :ok # UserProfileSerializer
    # render_success_response('User fetched successfully', @user)
  end

  def profile
    render json: @current_user, serializer: Users::UserSerializer, status: :ok
    # render_success_response('Profile fetched successfully', @current_user)
  end

  def update
    if @user.update!(user_params)
      render json: { message: "Hi, You've updated successfully user #{@user.id} data", user: @user }, status: :ok

    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def edit
    if @current_user.update(user_params)
      render_success_response('Profile updated successfully', @current_user)
      # ProfileMailer.with(user: current_user).update_email.deliver_later
    else
      render_unprocessable_entity_response(@current_user.errors)
    end
    # rescue ArgumentError => e #  StandardError => e
    #   render_unprocessable_entity_response(e)
  end

  def destroy
    @user.destroy

    # head :no_content
    render_no_content_response('User deleted successfully')
    # rescue ActiveRecord::RecordNotDestroyed => e
    #   render json: { errors: e.message }, status: :unprocessable_entity
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    # binding.pry
    @user = User.find(params[:id])
    # rescue ActiveRecord::RecordNotFound => e
    #   render_not_found_response(e.message)
  end

  def set_current_user
    @current_user = current_api_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(
      :username, :password, :phone_number, :age_group, :verification_status,
      { profile: %i[avatar_url bio first_name last_name sex phone_verified date_of_birth interests languages privacy_policy] },
      { location: %i[country state city zip_code address] },
      { social_links: %i[facebook twitter instagram linkedin youtube] }
    )
  end
end
