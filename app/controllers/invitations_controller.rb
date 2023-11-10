class InvitationsController < ApplicationController
  before_action :set_invitation, except: :send_invitation_mail

  def index
    @invitations_sent_by_me = Invitation.where(group_id: current_user.leading_groups.ids)
    @invitations_for_me = Invitation.where(musician_id: current_user.id)
  end

  def join_group
    @invitation = Invitation.find(invitation_params[:id])
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

    InvitationsMailer.create(invitation).deliver
  end

  def destroy
    @invitation.update_attribute(:status, 'cancelled')
    redirect_to invitations_path
  end

  def add_user_to_group
    @invitation = Invitation.find(invitation_params[:id])

    GroupMembership.create!(
      group_id: invitation_params[:group_id],
      musician_id: invitation_params[:musician_id],
      instrument_id:  invitation_params[:instrument_id]
    )

    InvitationsMailer.accept(@invitation).deliver
    flash[:notice] = 'Пользователь был успешно добавлен в группу'
    redirect_to group_path(invitation_params[:group_id])
  end

  private

  def set_invitation
    @invitation = Invitation.find_by(id: invitation_params[:id])
  end

  def invitation_params
    params.permit(:group_id, :musician_id, :token, :id, :instrument_id)
  end
end
