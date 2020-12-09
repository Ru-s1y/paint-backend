# @favopic.picture
json.meta do
  json.total_pages @favopics.total_pages
  json.current_page @favopics.current_page
end

json.favorites do
  json.array! @favopics do |favopic|
    json.id favopic.picture.id
    json.title favopic.picture.title
    json.description favopic.picture.description
    json.image_path favopic.picture.image_path
    json.username favopic.picture.user.name
  end
end