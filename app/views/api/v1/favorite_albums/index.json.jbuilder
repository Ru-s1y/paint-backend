json.meta do
  json.total_pages @favoalbs.total_pages
  json.current_page @favoalbs.current_page
end

json.favorites do
  json.array! @favoalbs do |favoalbum|
    json.id favoalbum.album.id
    json.title favoalbum.album.title
    json.description favoalbum.album.description
    json.username favoalbum.album.user.name
  end
end