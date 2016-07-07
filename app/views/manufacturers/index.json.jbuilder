json.array!(@manufacturers) do |manufacturer|
  json.extract! manufacturer, :id, :name, :address, :phone, :fax
  json.url manufacturer_url(manufacturer, format: :json)
end
