class StaffsController < ApplicationController
  before_action :authentication
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = Staff.all
    
     #chỉnh sửa
    if params[:search_name]
      @staffs = Staff.search_name(params[:search_name]).order("created_at DESC")
    elsif params[:search_email]
      @staffs = Staff.search_email(params[:search_email]).order("created_at DESC")
    else
      @staffs = Staff.all.order('created_at DESC')
    end
    #-------
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
    if current_staff.admin
    elsif current_staff.id == @staff.id
    else
      redirect_to staffs_path
    end
  end

  # GET /staffs/new
  def new
    if current_staff.admin
      @staff = Staff.new
    else
      redirect_to staffs_path
    end
  end

  # GET /staffs/1/edit
  def edit
    if current_staff.admin
    elsif current_staff.id == @staff.id
    else
      redirect_to staffs_path
    end
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        flash[:success] = t(".staff-create")
        format.html { redirect_to new_staff_path }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    respond_to do |format|
      if @staff.update(staff_params)
        flash[:success] = t(".staff-update")
        format.html { redirect_to edit_staff_path }
        format.json { render :show, status: :ok, location: @staff }
      else
        format.html { render :edit }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff.destroy
    respond_to do |format|
      flash[:success] = t(".staff-destroy")
      format.html { redirect_to staffs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      params.require(:staff).permit(:name, :birthday, :gender, :phone, :address, :email, :user, :password, :password_confirmation, :admin)
    end
    
    def authentication
      if logged_in?
      else
        redirect_to login_path
      end
    end
    
    
end
