class Subject < ActiveRecord::Base
  belongs_to :university

  validates :name, presence: true
end
