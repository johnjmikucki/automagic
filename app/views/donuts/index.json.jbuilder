json.array!(@donuts) do |donut|
  json.extract! donut, :id, :name, :ad_copy, :released
  json.url donut_url(donut, format: :json)
end
