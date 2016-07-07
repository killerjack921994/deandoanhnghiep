json.array!(@staffs) do |staff|
  json.extract! staff, :id, :name, :birthday, :gender, :phone, :address, :email
  json.url staff_url(staff, format: :json)
end
