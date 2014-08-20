require 'rspec'
require 'shoulda-matchers'
require 'activerecord'

require 'questions'
require 'responses'
require 'results'
require 'survey'

database_configuration = YAML::load(File.open('.db/config.yml'))
test_configuration = database_configuration['test']
ActiveRecord::Base.establish_connection(test_configuration)
