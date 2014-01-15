class Auditorium < ActiveRecord::Base
  self.table_name = 'auditoriums'

  belongs_to :university

  has_many :auditorium_names

  validates :name, presence: true
end
