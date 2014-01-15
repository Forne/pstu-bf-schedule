class Group < ActiveRecord::Base
  belongs_to :university

  has_many :entities
end
