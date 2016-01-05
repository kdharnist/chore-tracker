class Chore < ActiveRecord::Base

  has_many :chorepairings
  has_many :users, through: :chorepairings
end
