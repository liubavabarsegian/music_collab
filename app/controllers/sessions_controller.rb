# frozen_string_literal: true

# class SessionsController
class SessionsController < ApplicationController
    before_action :no_autorize, only: %i[new create]
    before_action :autorize, only: :destroy
    def new; end
  
    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def create
      @user = User.find_by(email: params[:email])
      if !!@user && @user.authenticate(params[:password])
        if @user.email_confirmed?
          session[:user_id] = @user.id
          session[:user_nick] = @user.nick
          flash[:success] = t(:you_have_successfully_logged_in)
          
        else
          flash[:error] = t(:confirm_you_email)
          
        end
      else
        flash[:error] = t(:incorrect_password_or_email)
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
  
    def destroy
      
      return unless user_signed_in?
  
      session.delete :user_id
      flash[:success] = t(:successfull_exit)
      
    end
end
