class University < ActiveRecord::Base
  has_many :auditoriums, :class_name => 'Auditorium'
  has_many :groups
  has_many :subjects
  has_many :teachers
  has_many :auditorium_names, :class_name => 'AuditoriumName'
  has_many :subject_names
  has_many :teacher_names

  validates :name, presence: true
end
