class RequestToGroupMailer < ApplicationMailer
  default from: "musicolllab@gmail.com"
  layout false

  def  send_request(request)
    @request = request
    @group = request.group
    @musician = request.musician

    begin
      mail(to: request.group.leader.email, subject: 'Приглашение на вступление в группу')
    rescue StandardError => e
      Rails.logger.error("Error sending email: #{e.message}")
    end
  end
end
