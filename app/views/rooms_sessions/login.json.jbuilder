json.status 'created'
json.room_logged_in true
json.room do
  json.id @room.id
  json.name @room.name
  json.description @room.description
  json.username @user.name
end