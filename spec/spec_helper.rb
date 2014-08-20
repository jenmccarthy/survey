require 'rspec'
require 'shoulda-matchers'
require 'active_record'

require 'questions'
require 'responses'
require 'results'
require 'survey'

database_configuration = YAML::load(File.open('db/config.yml'))
test_configuration = database_configuration['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each { |survey| survey.destroy}
    Question.all.each { |question| question.destroy}
    Response.all.each { |response| response.destroy}
    Result.all.each { |result| result.destroy}
  end
end
