json.array!(@auditoriums) do |a|
  json.extract! a, :university_id, :id, :name, :shot_name
end
