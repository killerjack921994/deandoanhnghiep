Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vn/ do
    root 'static_page#home'
    
    get 'admin' => 'admin#index'
    get 'resign' => 'static_page#resign'
    post 'resign' => 'static_page#create_resign'
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
    get 'category/:id' => 'static_page#list_category', as: 'category_list'
    get 'book/:id' => 'static_page#book_details', as: 'book_details'
    post 'comment_book' => 'static_page#comment_book', as: 'comment_book'
    post 'find' => 'static_page#find_book', as: 'find'
    get  'thankyou' => 'static_page#order_detail', as: 'order_detail'
    
    resources :line_items
    resources :carts
    get 'order_f' => 'static_page#order'
    post 'order_f' => 'static_page#create_order'
    
    resources :staffs, path: 'admin/staffs'
    resources :customers, path: 'admin/customers'
    resources :manufacturers, path: 'admin/manufacturers'
    resources :authors, path: 'admin/authors'
    resources :books, path: 'admin/books' do
      collection do
        get :search_category
        get :search_author
        get :search_staff
      end
    end
    resources :categories, path: 'admin/categories'
    resources :orders, path: 'admin/orders' do
      collection do
        get :search_method
        get :search_payment
        get :search_process
        get :search_owner
      end
    end
    resources :comments, path: 'admin/comments' do
      collection do
        get :search_book
        get :search_owner
      end
    end
    
    get 'delete_category' => 'custom#delete_book_category'
    get 'delete_book' => 'custom#delete_order_book'
    get 'delete_book_item' => 'custom#delete_book_lineitem'
    
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
