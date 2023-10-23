class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :set_leader, only: [:create]

  # GET /groups or /groups.json
  def index
    @groups = Group.all

    #TODO: надо создать какую-нибудь зависимость между группами и инструментами.
    # например, инструмент <-> необходимое кол-во музыкантов, играющих на нем
    if params[:musical_instrument_id].present?
      @groups = @groups.joins(:group_instrument_requirements).where("group_instrument_requirements.instrument_id = ?", params[:musical_instrument_id])
    end
  
    if params[:music_genre_id].present?
      @groups = @groups.joins(:group_genres).where("group_genres.genre_id = ?", params[:music_genre_id])
    end
  
    if params[:country_id].present?
      @groups = @groups.where(country_id: params[:country_id])
    end

    if params[:region_id].present?
      @groups = @groups.where(region_id: params[:region_id])
    end

    if params[:city_id].present?
      @groups = @groups.where(city_id: params[:city_id])
    end

    if params[:has_concert_experience]
      @groups = @groups.where(has_concert_experience: params[:has_concert_experience])
    end

    if params[:user_id]
      @groups = @groups.joins(:group_memberships).where('group_memberships.musician_id = ?', params[:user_id])
    end

  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.create(group_params)

    respond_to do |format|
      if @group.valid?
        instrument_quantities.each do |instrument_id, quantity|
          GroupInstrumentRequirement.create!(
            group_id: @group.id,
            instrument_id: instrument_id,
            quantity: quantity
          ) unless quantity.blank?
        end

        format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_instrument_requirement
    respond_to do |format|
      format.html         { render :add_instrument_requirement } # renders `page.html.erb`
      format.turbo_stream { render :add_instrument_requirement } # renders `page.turbo_stream.erb`
    end
  end

  def send_invitation_mail
    invitation = Invitation.create!(
      group_id: user_to_group_params[:group_id],
      musician_id: user_to_group_params[:musician_id],
      token: SecureRandom.uuid
    )

    InvitationToGroupMailer.invite_user_to_group(invitation).deliver
  end

  def join_group
    @group = Group.find(user_to_group_params[:group_id])
    @musician = User.find(user_to_group_params[:musician_id])
    @token = user_to_group_params[:token]
  end

  def add_user_to_group
    GroupMembership.create!(
      group_id: user_to_group_params[:group_id],
      musician_id: user_to_group_params[:musician_id],
      instrument_id: MusicalInstrument.last.id
    )
    redirect_to group_path(user_to_group_params[:group_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    def set_leader
      params.require(:group).merge!(leader_id: current_user.id)
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name, :leader_id, :description, :city, :members_number,
        group_genres_attributes: [:genre_id])
    end

    def instrument_quantities
      params.require(:group).require(:instrument_quantities).permit!
    end

    def user_to_group_params
      params.permit(:group_id, :musician_id, :token)
    end
end
