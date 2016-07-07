class CategoriesController < ApplicationController
  before_action :authentication
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
   @categories = Category.all
    #chỉnh sửa
    if params[:search]
      @categories = Category.search(params[:search]).order("created_at DESC")
    else
      @categories = Category.all.order('created_at DESC')
    end
    #-------
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    if current_staff.admin
    else
      redirect_to categories_path
    end
  end

  # GET /categories/new
  def new
    if current_staff.admin
      @category = Category.new
    else
      redirect_to categories_path
    end
  end

  # GET /categories/1/edit
  def edit
    if current_staff.admin
    else
      redirect_to categories_path
    end
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        flash[:success] = t('.category-create')
        format.html { redirect_to new_category_path }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        flash[:success] = t('.category-update')
        format.html { redirect_to edit_category_path }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      flash[:success] = t('.category-destroy')
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :description)
    end
    
    def authentication
      if logged_in?
      else
        redirect_to login_path
      end
    end
    
     
end
