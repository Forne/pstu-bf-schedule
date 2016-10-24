json.array!(@teachers) do |teacher|
  json.extract! teacher, :university_id, :id, :full_name
end
