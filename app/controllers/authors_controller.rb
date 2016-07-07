class AuthorsController < ApplicationController
  before_action :authentication
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all
     #chỉnh sửa
    if params[:search]
      @authors = Author.search(params[:search]).order("created_at DESC")
    else
      @authors = Author.all.order('created_at DESC')
    end
    #-------
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    if current_staff.admin
    else
      redirect_to authors_path
    end
  end

  # GET /authors/new
  def new
    if current_staff.admin
      @author = Author.new
    else
      redirect_to authors_path
    end
  end

  # GET /authors/1/edit
  def edit
    if current_staff.admin
    else
      redirect_to authors_path
    end
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        flash[:success] = t('.author-create')
        format.html { redirect_to new_author_path }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        flash[:success] = t('.author-update')
        format.html { redirect_to edit_author_path }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      flash[:success] = t('.author-destroy')
      format.html { redirect_to authors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:name, :birthday, :description, :homeland)
    end
    
    def authentication
    if logged_in?
    else
      redirect_to login_path
    end
  end
end
