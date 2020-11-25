json.array! @favoalb do |favoalbum|
  json.id favoalbum.album.id
  json.title favoalbum.album.title
  json.description favoalbum.album.description
  json.username favoalbum.album.user.name
end