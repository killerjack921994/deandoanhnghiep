class StaticPageController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def home
    @book = Book.all
  end
  
  def list_category
    @category = Category.find(params[:id])
    @book = @category.book.paginate(:page => params[:page], :per_page => 6)
  end
  
  def book_details
    @book = Book.find(params[:id])
    @comment = Comment.new
  end
  
  def comment_book
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        flash[:success] = t('.comment-success')
        format.html { redirect_to book_details_path(@comment.book_id) }
      else
        flash[:danger] = t('.comment-error')
        format.html { redirect_to book_details_path(@comment.book_id) }
      end
    end   
  end
  
  def find_book
    @character = params[:book]
    @book = Book.where(["name LIKE ?", "%#{@character}%"])
  end
  
  def resign
    @staff = Staff.new
  end
  
  def create_resign
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        flash[:success] = t(".resign-create")
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :resign }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def order
    if logged_in?
      if @cart.line_items.empty?
        flash[:danger] = t("order-cart")
        redirect_to root_url
        return
      end
      @order = Order.new
    else
      redirect_to login_path
      flash[:danger] = t('.order-login')
    end
  end
  
  def create_order
    if logged_in?
      @order = Order.new(order_params)
      @order.add_line_items_from_cart(@cart)
      
      respond_to do |format|
        if @order.save
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
          session[:order_id] = @order.id
          flash[:success] = t('.order-create')
          format.html { redirect_to order_detail_path }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :order }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to login_path
    end
  end
  
  def order_detail
      @order = Order.find(session[:order_id])
  end
  
  def staff_params
      params.require(:staff).permit(:name, :birthday, :gender, :phone, :address, :email, :user, :password, :password_confirmation)
  end
  
  def order_params
      params.require(:order).permit( :name, :method, :payment, :staff_id, :process)
  end
  
  def comment_params
      params.require(:comment).permit( :name, :comment, :book_id, :staff_id)
  end
end
