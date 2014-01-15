class Entity < ActiveRecord::Base
  belongs_to :auditorium
  belongs_to :group, touch: true
  belongs_to :subject
  belongs_to :teacher
  belongs_to :entity_type, foreign_key: 'type_id'
end
