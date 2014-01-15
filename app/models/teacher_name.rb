class TeacherName < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :university

  validates :name, :teacher_id, presence: true
end
