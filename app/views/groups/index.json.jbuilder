json.array!(@groups) do |group|
  json.extract! group, :id, :name, :runner_id
  json.url group_url(group, format: :json)
end
