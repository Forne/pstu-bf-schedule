json.extract! @teacher, :id, :full_name, :updated_at
json.from @from
json.to @to
json.schedule @schedule do |event|
  json.start event.start
  json.end event.end
  json.subject event.subject, :id, :name
  json.type event.entity_type, :id, :name
  if event.group
    json.group event.group, :id, :name
  end
  if event.teacher
    json.teacher event.teacher, :id, :full_name
  end
  if event.auditorium
    json.auditorium event.auditorium, :id, :name, :shot_name
  end
end