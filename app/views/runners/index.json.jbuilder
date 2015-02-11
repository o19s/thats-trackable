json.array!(@runners) do |runner|
  json.extract! runner, :id, :name, :group, :role
  json.url runner_url(runner, format: :json)
end
