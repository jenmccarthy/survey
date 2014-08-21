class Choice < ActiveRecord::Base
  belongs_to :response
  belongs_to :question
  has_and_belongs_to_many :results

end
