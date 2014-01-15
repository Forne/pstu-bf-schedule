class SubjectName < ActiveRecord::Base
  belongs_to :subject

  validates :name, :subject_id, presence: true, uniqueness: true
end
