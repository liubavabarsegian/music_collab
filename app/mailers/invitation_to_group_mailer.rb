class InvitationToGroupMailer < ApplicationMailer
  default from: "musicolllab@gmail.com"
  layout false

  def invite_user_to_group(invitation, token)
    @invitation = invitation
    @token = token

    mail(to: invitation.musician.email, subject: 'You are invited to join a group')
  end
end
