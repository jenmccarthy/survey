require 'active_record'
require './lib/question'
require './lib/response'
require './lib/result'
require './lib/survey'
require 'pry'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def welcome
  system 'clear'
  puts "Welcome to Survey Maker"
  puts "Are you a maker or a taker?"
  puts "M << Maker"
  puts "T << Taker"
  choice = gets.chomp
  case choice.upcase
  when 'M'
    maker_menu
  when 'T'
    taker_menu
  end
end

def maker_menu
  system 'clear'
  puts "Maker Menu Choices"
  puts "[M] Make a new survey"
  puts "[L] List all surveys"
  puts "[Q] Create questions for a survey"
  puts "[R] Create responses for questions"
  case gets.chomp.upcase
  when "M"
    new_survey
  when "L"
    list_surveys
  when "Q"
    create_questions
  when "R"
    create_responses
  else
    invalid
    maker_menu
  end
end

def invalid
  puts "Your choice is invalid"
  sleep(2)
end

def new_survey
  puts "Please enter the name of this survey:"
  new_survey = Survey.create({name: gets.chomp})
  if new_survey.valid?
    puts "Your new survey has been created!"
    sleep 2
  else
    puts "You blew it! Here's why:"
    new_survey.errors.full_messages.each { |message| puts message }
    sleep 2
  end
    puts "What would you like to do?"
    puts "[A] Add questions to this survey"
    puts "[X] Return to main menu"
  case gets.chomp.upcase
  when "A"
    create_questions
  else
    maker_menu
  end
end

def list_surveys
  puts "Here are all the surveys created so far:"
  Survey.all.each { |survey| puts "#{survey.name}" }
  gets
end

def create_questions
  puts "Your current survey name: #{Survey.all.last.name}"
  puts "Please enter the question:"
  question_input = gets.chomp
  puts "Please enter the kind of question this is:"
  show_question_types.each_with_index { |question, index | puts "#{index + 1} #{question}"}
  kind_input = gets.chomp.to_i - 1
  new_question = Question.create({question: question_input, kind: show_question_types[kind_input]})
  if new_question.valid?
    Survey.all.last.questions << new_question
  else
    puts "You blew it! Here's why:"
    new_question.errors.full_messages.each { |message| puts message }
    sleep 2
  end
    puts "Here are your questions so far:"
    Survey.all.last.questions.each { | question | puts "#{question.question}" }
  puts "\nWhat would you like to do?"
  puts "[R] Add responses to this question"
  puts "[A] Add more questions to this survey"
  puts "[X] Return to main menu"
  case gets.chomp.upcase
  when "A"
    create_questions
  when "R"
    create_responses
  else
    maker_menu
  end
end

def create_responses
  puts "Your current question: #{Question.all.last.question} of type (#{Question.all.last.kind})"
  current_question_kind = Question.all.last.kind
  if current_question_kind == 'multiple choice'
    puts "Please enter four different response choices for this question."
    0.upto(3) { Question.all.last.responses << Response.create({response: gets.chomp}) }
  elsif current_question_kind == 'Y/N'
    Question.all.last.responses << Response.create({response: 'Yes'})
    Question.all.last.responses << Response.create({response: 'No'})
  elsif current_question_kind == 'true/false'
    Question.all.last.responses << Response.create({response: 'True'})
    Question.all.last.responses << Response.create({response: 'False'})
  end
  puts "Responses created!"
  sleep 2
  puts "What would you like to do?"
  puts "[A] Add another question to your survey"
  puts "[X] Return to main menu"
  case gets.chomp.upcase
  when "A"
    create_questions
  when "R"
    create_responses
  else
    invalid
    maker_menu
  end
end

def show_question_types
  types = ['multiple choice', 'Y/N', 'true/false', 'other']
end

welcome
