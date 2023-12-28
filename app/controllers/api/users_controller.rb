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
             end
    if @users.any?
      # render json: @users, each_serializer: Users::UserSerializer, status: :ok
      # @users.paginate(page: params[:page] || 1, per_page: @items_per_page),
      render_success_response('Users fetched successfully', @users, serializer: Users::UserSerializer)
    else
      render_not_found_response("No users #{params[:search]} with the given search criteria.")
    end
  end

  def show
    # render json: @user, serializer: Users::UserSerializer, status: :ok # UserProfileSerializer
    render_show_response('User fetched successfully', @user, serializer: Users::UserSerializer)
  end

  def profile
    render_show_response('Profile fetched successfully', @current_user,
                         serializer: Users::UserProfileSerializer)
  end

  def update
    if @user.update!(user_params)
      render_show_response('User updated successfully', @user,
                           serializer: Users::UserSerializer)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def edit
    if @current_user.update(user_params)
      render_show_response('Profile updated successfully', @current_user,
                           serializer: Users::UserProfileSerializer)
      # location: api_movie_writter_url(@movie_writter)) TODO: Config the location from the router
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
      { profile: %i[avatar_url bio date_of_birth first_name last_name interests languages phone_verified sex] },
      { location: %i[country state city zip_code address] },
      { social_links: %i[facebook instagram linkedin twitter youtube] }
    )
  end
end
