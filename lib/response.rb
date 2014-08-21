class Response < ActiveRecord::Base
  has_many :choices
  has_many :questions, through: :choices
  # has_and_belongs_to_many :questions
end
