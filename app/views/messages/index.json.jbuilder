json.array!(@messages) do |message|
  json.extract! message, :body, :project_id, :user_id, :bookmark
  json.url message_url(message, format: :json)
end
