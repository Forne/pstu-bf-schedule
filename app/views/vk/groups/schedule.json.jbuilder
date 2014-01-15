json.extract! @group, :id, :name, :updated_at
json.from @from
json.to @to
json.schedule @schedule do |event|
  json.start event.start
  json.end event.end
  json.subject event.subject, :id, :name
  json.type event.entity_type, :id, :name
  json.teacher event.teacher, :id, :full_name
  json.auditorium event.auditorium, :id, :name
end