class Teacher < ActiveRecord::Base
  include Petrovich::Extension

  petrovich :firstname => :firstname,
            :middlename => :middlename,
            :lastname => :lastname

  belongs_to :university

  validates :full_name, presence: true

  def firstname
    self.full_name.split(" ")[1]
  end

  def lastname
    self.full_name.split(" ")[0]
  end

  def middlename
    self.full_name.split(" ")[2]
  end

  def group_by_first_letter
    full_name[0]
  end
end