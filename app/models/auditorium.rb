class Auditorium < ActiveRecord::Base
  self.table_name = 'auditoriums'

  belongs_to :university

  validates :name, presence: true
end
