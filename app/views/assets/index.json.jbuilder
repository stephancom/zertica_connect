json.array!(@assets) do |asset|
  json.extract! asset, :project_id, :title, :notes
  json.url asset_url(asset, format: :json)
end
