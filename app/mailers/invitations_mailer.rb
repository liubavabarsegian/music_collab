class InvitationsMailer < ApplicationMailer
  default from: "musicolllab@gmail.com"
  layout false

  def create(invitation)
    @invitation = invitation
    @token = invitation.token
    @group = invitation.group
    @musician = invitation.musician

    begin
      mail(to: invitation.musician.email, subject: 'Приглашение на вступление в группу')
    rescue StandardError => e
      Rails.logger.error("Error sending email: #{e.message}")
    end
  end

  def accept(invitation)
    @invitation = invitation
    @token = invitation.token
    @group = invitation.group
    @musician = invitation.musician


    begin
      mail(to: invitation.group.leader.email, subject: 'Приглашение на вступление в группу принято')
    rescue StandardError => e
      Rails.logger.error("Error sending email: #{e.message}")
    end
  end
end
