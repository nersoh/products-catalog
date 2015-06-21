class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  after_action :verify_authorized
  #before_action :require_permission, only: [:edit, :update, :destroy]
  #before_action :authorize_user, only: [:new, :create, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    authorize @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize @user
  end

  # GET /users/new
  def new
    @user = User.new
    authorize @user
  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    authorize @user
    respond_to do |format|
      if @user.save
        flash[:success] = 'User was successfully created.' 
        format.html { redirect_to @user }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize @user
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end

    def require_permission
      @user = User.find(params[:id])
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "You don't have permission to modify this user's."
        redirect_to(request.referrer || root_url)
      end
    end
end
