# class Api::UsersController < ApplicationController
module Api
  class UsersController < ApplicationController
    # before_action :authenticate_user!
    before_action :set_user, only: %i[show update destroy]
    before_action :set_current_user, only: %i[index profile edit]

    def index
      @users = if params[:search].present?
                 User.where('username LIKE :search OR email LIKE :search', search: "%#{params[:search]}%")
               else
                 User.all
               end

      if @users.any?
        render_success_response('Users fetched successfully', @users)
      else
        render_not_found_response('No users found with the given search criteria.')
      end
    end

    def show
      render_success_response('User fetched successfully', @user)
    end

    def profile
      render_success_response('Profile fetched successfully', @current_user)
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
    rescue ArgumentError => e #  StandardError => e
      render_unprocessable_entity_response(e)
    end

    def destroy
      @user.destroy

      # head :no_content
      render json: {
        status: 'success',
        message: "#{@user.email} has been deleted Successfully!!!"
      }, status: :ok
      # redirect_to root_url
    rescue ActiveRecord::RecordNotDestroyed => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      # binding.pry
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render_not_found_response(e.message)
    end

    def set_current_user
      @current_user = current_user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(
        :username, :password, :phone_number, :age_group,
        { profile: %i[avatar_url bio first_name last_name sex phone_verified date_of_birth interests languages privacy_policy] },
        { location: %i[country state city zip_code address] },
        { social_links: %i[facebook twitter instagram linkedin youtube] }
      )
    end
  end
end
