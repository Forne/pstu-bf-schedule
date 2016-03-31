json.array!(@groups) do |group|
  json.extract! group, :university_id, :id, :name, :archive
end
