class CommentsController < ApplicationController
  before_action :authentication
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
      #chỉnh sửa
    if params[:search]
      @comments = Comment.search(params[:search]).order("created_at DESC")
    else
      @comments = Comment.all.order('created_at DESC')
    end
    #-------
  end

  def search_book
		if params[:id]
			@comments = Comment.search_book(params[:id])
		else
			@comments = Comment.all
		end
		render :template => "comments/index"
	end
  
  def search_owner
		if params[:id]
			@comments = Comment.search_owner(params[:id])
		else
			@comments = Comment.all
		end
		render :template => "comments/index"
	end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    if current_staff.admin?
    elsif current_staff.id == @comment.staff_id
    else
      redirect_to comments_path
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        flash[:success] = t(".comment-create")
        format.html { redirect_to new_comment_path }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        flash[:success] = t(".comment-update")
        format.html { redirect_to edit_comment_path }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      flash[:success] = t(".comment-destroy")
      format.html { redirect_to comments_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:name, :comment, :book_id, :staff_id)
    end
    
    def authentication
      if logged_in?
      else
        redirect_to login_path
      end
    end
end
