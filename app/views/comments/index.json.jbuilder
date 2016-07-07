json.array!(@comments) do |comment|
  json.extract! comment, :id, :name, :comment, :user
  json.url comment_url(comment, format: :json)
end
