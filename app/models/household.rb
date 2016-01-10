class Household < ActiveRecord::Base

	has_many :users
	has_many :chores, through: :users

	validates :name, presence: true

end
