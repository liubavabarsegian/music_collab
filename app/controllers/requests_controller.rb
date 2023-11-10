class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :accept, :deny]

  def index
    @requests_to_my_groups = Request.where(group_id: current_user.leading_groups.ids)
    @requests_by_me = Request.where(musician_id: current_user.id)
  end

  def show
  end

  def new
    @group = Group.find(request_params[:group_id])
  end

  def create
    request = Request.create!(
      group_id: request_params[:group_id],
      musician_id: request_params[:musician_id],
      instrument_id:  request_params[:instrument_id],
      status: 'pending'
    )

    RequestsMailer.send_request(request).deliver
    redirect_to group_path(request_params[:group_id])
  end

  def accept
    @request.update({status: 'accepted'})

    GroupMembership.create!(
      musician_id: @request.musician_id,
      group_id: @request.group_id,
      instrument_id: @request.instrument_id
    )

    RequestsMailer.accept(@request).deliver
    flash[:notice] = 'Пользователь был успешно добавлен в группу'
    redirect_to group_path(@request.group_id)
  end

  def deny
    @request.update({status: 'denied'})

    RequestsMailer.deny(@request).deliver
    flash[:notice] = 'Пользователю было отказано в запросе на вступление в группу'
    redirect_to group_path(@request.group_id)
  end

  def add_user_to_group
    GroupMembership.create!(
      group_id: user_to_group_params[:group_id],
      musician_id: user_to_group_params[:musician_id],
      instrument_id:  user_to_group_params[:instrument_id]
    )

    redirect_to group_path(user_to_group_params[:group_id])
  end

  private

  def request_params
    params.permit(:group_id, :id, :musician_id, :instrument_id)
  end

  def set_request
    @request = Request.find_by(id: request_params[:id])
  end
end
