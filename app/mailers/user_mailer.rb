# frozen_string_literal: true

# user mailer
class UserMailer < ApplicationMailer
    def registration_confirmation(user)
      @user = user
      mail to: @user.email, subject: 'Email confirmation'
    end
  end
