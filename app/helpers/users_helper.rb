# frozen_string_literal: true

# users helper
module UsersHelper
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def confirm_email
      user = User.find_by_confirm_token(params[:id])
      if user
        user.email_activate
        flash[:success] = "Welcome, #{user.name}"
        session[:user_id] = user.id
        session[:user_nick] = user.name
        # redirect_to root_path
      else
        flash[:error] = 'No user found with such email'
        # redirect_to new_path
      end
      nil
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
  end
