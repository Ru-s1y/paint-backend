json.meta do
  json.total_pages @rooms.total_pages
  json.current_page @rooms.current_page
end
json.data do
  json.array! @rooms, :id, :name, :description, :user_id
end