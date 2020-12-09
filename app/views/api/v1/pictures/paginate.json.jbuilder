json.meta do
  json.total_pages @pictures.total_pages
  json.current_page @pictures.current_page
end

json.pictures do
  json.array! @pictures do |picture|
    json.id picture.id
    json.title picture.title
    json.description picture.description
    json.publish picture.publish
    json.image_path picture.image_path
    json.pagenumber picture.pagenumber
    json.album_title picture.album.title
    json.username picture.user.name
  end
end