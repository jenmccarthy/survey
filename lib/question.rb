class Question < ActiveRecord::Base
  has_many :choices
  has_many :responses, through: :choices
  has_and_belongs_to_many :surveys
  # has_and_belongs_to_many :responses

  validates :question, presence: true
end
