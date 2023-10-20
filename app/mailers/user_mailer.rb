class UserMailer < ApplicationMailer
  default from: 'support@hillwoodempire.org'
  # reply_to: 'hillwoodempire@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:

  def welcome_email
    # @greeting = "Hi"
    @user = params[:user]
    @url = 'http://localhost:8000/auth/sign_in'
    mail(to: @user.email, subject: 'Welcome to Hillwood Empire.')
  end
end
