# json.array! @albums, :id, :title, :description, :publish, :user_id

json.array! @albums do |album|
  json.id album.id
  json.title album.title
  json.description album.description
  json.publish album.publish
  json.username album.user.name
end