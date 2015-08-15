json.array!(@activities) do |activity|
  json.extract! activity, :id, :key, :parameters, :owner_id
  json.url activity_url(activity, format: :json)
end
