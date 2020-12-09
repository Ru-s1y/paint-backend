json.meta do
  json.total_pages @albums.total_pages
  json.current_page @albums.current_page
end

json.albums do
  json.array! @albums do |album|
    json.id album.id
    json.title album.title
    json.description album.description
    json.publish album.publish
    json.username album.user.name
  end
end