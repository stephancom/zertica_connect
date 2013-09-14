json.array!(@projects) do |project|
  json.extract! project, :title, :state, :user_id, :spec, :deadline
  json.url project_url(project, format: :json)
end
