json.array!(@projects) do |project|
  json.extract! project, :title, :user_id, :spec, :deadline
  json.url project_url(project, format: :json)
end
