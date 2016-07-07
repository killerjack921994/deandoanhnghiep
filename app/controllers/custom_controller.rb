class CustomController < ApplicationController
    def delete_book_category
        flash[:success] = t('.book-category')
        @book_id = params[:id]
        @book = Book.find(@book_id)
        @book.category.delete(params[:id_category])
        redirect_to edit_book_path(@book_id)
    end
    
    def delete_order_book
        flash[:success] = t('.book-order')
        @order_id = params[:id]
        @order = Order.find(@order_id)
        @order.book.delete(params[:id_book])
        redirect_to edit_order_path(@order_id)
    end
    def delete_book_lineitem
        flash[:success] = t('.book-lineitem')
        @book = Book.find(params[:id])
        @book.line_items.where(book_id: params[:id]).destroy_all
        redirect_to root_path
    end
end
