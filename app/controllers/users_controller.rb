class UsersController < ApplicationController
  before_action :validate_user_pressence, except: [:index, :show]
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all

    if params[:musical_instrument_id].present?
      @users = @users.joins(:musician_instruments).where("musician_instruments.instrument_id = ?", params[:musical_instrument_id])
    end
  
    if params[:music_genre_id].present?
      @users = @users.joins(:musician_genres).where("musician_genres.genre_id = ?", params[:music_genre_id])
    end
  
    if params[:country_id].present?
      @users = @users.where(country_id: params[:country_id])
    end

    if params[:region_id].present?
      @users = @users.where(region_id: params[:region_id])
    end

    if params[:city_id].present?
      @users = @users.where(city_id: params[:city_id])
    end

    if params[:has_concert_experience]
      @users = @users.where(has_concert_experience: params[:has_concert_experience])
    end

    if user_signed_in?
      @users = @users.where('id <> ?', current_user.id)
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :surname, :birthday, :country_id, :region_id, :city_id,
        :career_start_year,  :has_concert_experience, musical_instrument_ids: [], genre_ids: [])
    end
end
