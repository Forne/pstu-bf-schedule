class AuditoriumName < ActiveRecord::Base
  belongs_to :auditorium
  belongs_to :university

  validates :name, :auditorium_id, presence: true, uniqueness: true
end
