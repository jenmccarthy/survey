require 'rspec'
require 'active_record'
require 'shoulda-matchers'

require 'question'
require 'response'
require 'result'
require 'survey'
require 'choice'

I18n.enforce_available_locales = false

database_configuration = YAML::load(File.open('db/config.yml'))
test_configuration = database_configuration['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each { |survey| survey.destroy}
    Question.all.each { |question| question.destroy}
    Response.all.each { |response| response.destroy}
    Result.all.each { |result| result.destroy }
    Choice.all.each { |choice| choice.destroy }
  end
end
