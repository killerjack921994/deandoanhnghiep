class OrdersController < ApplicationController
  before_action :authentication
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end
  
  def search_method
		if params[:method]
			@orders = Order.search_method(params[:method])
		else
			@orders = Order.all
		end
		render :template => "orders/index"
	end
  
  def search_payment
		if params[:payment]
			@orders = Order.search_payment(params[:payment])
		else
			@orders = Order.all
		end
		render :template => "orders/index"
	end

  def search_process
		if params[:process]
			@orders = Order.search_process(params[:process])
		else
			@orders = Order.all
		end
		render :template => "orders/index"
	end
  
  def search_owner
		if params[:id]
			@orders = Order.search_owner(params[:id])
		else
			@orders = Order.all
		end
		render :template => "orders/index"
	end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if current_staff.admin
    else
      redirect_to orders_path
    end
  end

  # GET /orders/new
  def new
    if current_staff.admin
      @order = Order.new
    else
      redirect_to orders_path
    end
  end

  # GET /orders/1/edit
  def edit
    if current_staff.admin
    else
      redirect_to orders_path
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    
    params[:order][:book].delete("")
    if params[:order][:book].empty?
			flash[:danger] = t("order-book")
			render :new
		else
			@array_book = params[:order][:book]
			@book = Book.find(@array_book)
	
			respond_to do |format|
				if @order.save
					
					@order.book << @book
					
					flash[:success] = t('.order-create')
					format.html { redirect_to new_order_path}
					format.json { render :show, status: :created, location: @order }
				else
					format.html { render :new }
					format.json { render json: @order.errors, status: :unprocessable_entity }
				end
			end
		end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    params[:order][:book].delete("")
    @array_book = params[:order][:book]
    @book = Book.find(@array_book)
    
    respond_to do |format|
      if @order.update(order_params)
        
        @order.book.delete(@book)
        @order.book << @book
        
        flash[:success] = t('.order-update')
        format.html { redirect_to edit_order_path }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      flash[:success] = t('.order-destroy')
      format.html { redirect_to orders_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit( :name, :method, :book, :payment, :staff_id, :process)
    end
    
    def authentication
      if logged_in?
      else
        redirect_to login_path
      end
    end
end
