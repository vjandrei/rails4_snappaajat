json.array!(@profiles) do |profile|
  json.extract! profile, :id, :name, :nickname, :description, :facebook, :twitter, :instagram, :linkedin
  json.url profile_url(profile, format: :json)
end
