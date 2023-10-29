class InvitationsController
  def join_group
    @group = Group.find(invitation_params[:group_id])
    @musician = User.find(invitation_params[:musician_id])
    @token = invitation_params[:token]
  end

  def send_invitation_mail
    invitation = Invitation.create!(
      group_id: invitation_params[:group_id],
      musician_id: invitation_params[:musician_id],
      token: SecureRandom.uuid
    )

    InvitationToGroupMailer.invite_user_to_group(invitation).deliver
  end

  private

  def invitation_params
    params.permit(:group_id, :musician_id, :token)
  end
end
