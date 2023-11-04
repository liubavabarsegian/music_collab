class InvitationsController < ApplicationController
  def index
    @invitations_sent_by_me = Invitation.where(group_id: current_user.leading_groups.ids)
    @invitations_for_me = Invitation.where(musician_id: current_user.id)
  end

  def join_group
    @group = Group.find(invitation_params[:group_id])
    @musician = User.find(invitation_params[:musician_id])
    @token = invitation_params[:token]
  end

  def send_invitation_mail
    invitation = Invitation.create!(
      group_id: invitation_params[:group_id],
      musician_id: invitation_params[:musician_id],
      token: SecureRandom.uuid,
      status: 'pending'
    )

    InvitationToGroupMailer.invite_user_to_group(invitation).deliver
  end

  def destroy
    invitation = Invitation.find(invitation_params[:id])
    invitation.update_attribute(:status, 'cancelled')

    redirect_to invitations_path
  end

  private

  def invitation_params
    params.permit(:group_id, :musician_id, :token, :id)
  end
end
