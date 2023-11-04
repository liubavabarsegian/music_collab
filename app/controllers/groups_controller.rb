class GroupsController < ApplicationController
  before_action :validate_user_pressence, except: [:index]
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :set_leader, only: [:create]
  before_action :delete_music_genres, only: :update

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
      @groups = @groups.joins(:memberships).where('group_memberships.musician_id = ?', params[:user_id])
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
        create_instrument_requirements
        set_leader_as_musician

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
        delete_instrument_requirements
        create_instrument_requirements

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

  def add_user_to_group
    GroupMembership.create!(
      group_id: user_to_group_params[:group_id],
      musician_id: user_to_group_params[:musician_id],
      instrument_id:  user_to_group_params[:instrument_id]
    )

    flash[:notice] = 'Пользователь был успешно добавлен в группу'
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
      params.require(:group).permit(:name, :leader_id, :description, :country_id, :region_id, :city_id, 
        group_genres_attributes: [:genre_id])
    end

    def instrument_quantities
      params.require(:group).require(:instrument_quantities).permit!
    end

    def user_to_group_params
      params.permit(:group_id, :musician_id, :token)
    end

    def leader_instrument_id
      params.permit(:leader_instrument_id)
    end

    def create_instrument_requirements
      instrument_quantities.each do |instrument_id, quantity|
        GroupInstrumentRequirement.create!(
          group_id: @group.id,
          instrument_id: instrument_id,
          quantity: quantity
        ) unless quantity.blank?
      end
    end

    def delete_instrument_requirements
      GroupInstrumentRequirement.where(group_id: @group.id)&.delete_all
    end

    def delete_music_genres
      GroupGenre.where(group_id: @group.id)&.delete_all
    end

    def set_leader_as_musician
      if leader_instrument_id.present?
        GroupMembership.create!(
          group_id: @group.id,
          instrument_id: MusicalInstrument.find(leader_instrument_id),
          musician_id: current_user.id
        )
      end
    end

    def delete_leader_from_musicians
      GroupMembership.find_by(group_id: @group.id, musician_id: current_user.id)&.delete
    end
end
