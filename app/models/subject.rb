class Subject < ActiveRecord::Base
  belongs_to :university

  has_many :subject_names

  validates :name, presence: true
end
