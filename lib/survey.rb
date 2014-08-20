class Survey < ActiveRecord::Base
  has_and_belongs_to_many :questions
  has_many :responses, through: :questions

  validates :name, presence: true
end
