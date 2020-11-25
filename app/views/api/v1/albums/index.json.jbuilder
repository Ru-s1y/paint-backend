json.array! @albums do |album|
  json.id album.id
  json.title album.title
  json.description album.description
  json.publish album.publish
  json.username album.user.name
end