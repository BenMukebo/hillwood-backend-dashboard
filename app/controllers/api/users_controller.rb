# class Api::UsersController < ApplicationController
# end

# Create enum that will kepp success and error messages ; 
# NAME = { user: 0, super_admin: 2, subscriber: 3, admin: 4 }.freeze
# request_messages = {  { user: 0, super_admin: 2, subscriber: 3, admin: 4 }.freeze }

module Api
  class UsersController < ApplicationController
    # before_action :authenticate_user!
    before_action :set_user, only: %i[show update destroy]
    before_action :set_current_user, only: %i[index current_show current_edit]

    def index
      @users = User.all
      # @verified_users = User.all.where(remember: 3)
      # user_count = @users.count

      render json: {
        message: 'success',
        data: @users
      }, status: :ok
    end

    # GET /users/1
    def show
      render json: {
        message: request.success,
        data: @user
      }, status: 201
    end

    # GET /user
    def current_show
      render json: {
        message: request.success,
        data: @current_user
      }, status: 200

      # render json: {
      #   data: {
      #     message: "Welcome #{@current_user.username}",
      #     user: @current_user
      #   }
      # }, status: 200
    end

    # PATCH/PUT /users/1
    def update
      if @user.update!(user_params)
        render json: { message: "Hi, You've updated successfully user #{@user.id} data", user: @user }, status: :ok

      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PUT /user
    def current_edit
      if @current_user.update(user_params)
        render json: { message: 'User updated successfully', user: @current_user }, status: :ok
        # ProfileMailer.with(user: current_user).update_email.deliver_later
      else
        render json: { errors: @curent_user.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      @user.destroy

      render json: {
        status: 'success',
        message: "#{@user.email} has been deleted Successfully!!!"
      }, status: :ok
      # redirect_to root_url
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_current_user
      @current_user = current_user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :phone, :age_group, :remember_me)
    end
  end
end
