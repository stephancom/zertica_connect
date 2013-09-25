json.array!(@assets) do |asset|
  json.extract! asset, :project_id, :title, :notes, :visible
  json.url asset_url(asset, format: :json)
end
