# @favopic.picture
json.array! @favopics do |favopic|
  json.id favopic.picture.id
  json.title favopic.picture.title
  json.description favopic.picture.description
  json.image_path favopic.picture.image_path
  json.username favopic.picture.user.name
end