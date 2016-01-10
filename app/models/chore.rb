class Chore < ActiveRecord::Base

  belongs_to :user
  belongs_to :choretype

  validates :name, presence: true
end
