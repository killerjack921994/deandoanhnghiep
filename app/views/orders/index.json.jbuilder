json.array!(@orders) do |order|
  json.extract! order, :id, :index, :name, :email, :method
  json.url order_url(order, format: :json)
end
