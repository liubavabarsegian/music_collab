class ApplicationController < ActionController::Base
  def user_signed_in?
    current_user.present?
  end

  def validate_user_pressence
    redirect_to new_user_session_path unless current_user.present?
  end
end
