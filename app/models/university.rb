class University < ActiveRecord::Base
  has_many :auditoriums, :class_name => 'Auditorium'
  has_many :groups
  has_many :subjects
  has_many :teachers

  validates :name, presence: true
end
