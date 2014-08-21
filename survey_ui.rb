require 'active_record'
require './lib/question'
require './lib/response'
require './lib/result'
require './lib/survey'
require './lib/choice'
require 'pry'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

@user
@current_survey
@current_question

def welcome
  system 'clear'
  puts "Welcome to Survey Maker"
  puts "Are you a maker or a taker?"
  puts "[M] << Maker"
  puts "[T] << Taker"
  puts "[C] << Clear database!"
  choice = gets.chomp
  case choice.upcase
  when 'M'
    @user = "maker"
    maker_menu
  when 'T'
    @user = "taker"
    taker_menu
  when 'C'
    defcon5
    welcome
  end
end

def defcon5
  Survey.all.each { |survey| survey.destroy}
  Question.all.each { |question| question.destroy}
  Response.all.each { |response| response.destroy}
  Result.all.each { |result| result.destroy }
  Choice.all.each { |choice| choice.destroy }
end

# def taker_menu
#   system 'clear'
#   puts "Taker Menu Choices"
#   puts "[C] Choose a survey to take"
#   puts "[X] Exit"
#   case gets.chomp.upcase
#   when "C"
#     take_survey
#   when "X"
#     puts "Adios!"
#   end
# end

# def take_survey
#   list_surveys
#   puts "Please choose a survey you would like to take"
#   survey_choice = gets.chomp.to_i - 1
#   current_survey = Survey.all[survey_choice]
#   new_result = Result.create({survey_id: current_survey.id})
#   current_survey.questions.each do |question|
#     if question.kind != 'other'
#       puts "#{question.question}"
#       question.responses.each_with_index do |response, index|
#       # binding.pry
#         puts "#{index + 1} #{response.response}"
#       end
#     puts "Please choose the answer that best fits"
#     selection = gets.chomp.to_i - 1
#     new_choice = Choice.create({question_id: question.id, response_id: question.responses[selection].id})
#     new_result.choices << new_choice
#     else
#       puts "Please enter your response"
#     end
#   end
# end

def maker_menu
  system 'clear'
  puts "Maker Menu Choices"
  puts "[M] Make a new survey"
  puts "[L] List all surveys"
  puts "[E] Edit existing survey"
  puts "[Q] Create questions for a survey"
  puts "[R] Create responses for questions"
  case gets.chomp.upcase
  when "M"
    new_survey
  when "L"
    list_surveys
    puts "Press any key to continue"
    gets
    maker_menu
  when "E"
    edit_survey
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
  @current_survey = Survey.create({name: gets.chomp})
  if @current_survey.valid?
    puts "Your new survey has been created!"
    sleep 2
  else
    puts "You blew it! Here's why:"
    @current_survey.errors.full_messages.each { |message| puts message }
    sleep 2
  end
  create_questions
end

def list_surveys
  puts "\nHere are all the surveys created so far:"
  Survey.all.each_with_index do |survey, index|
    puts "#{index + 1}. #{survey.name.upcase} SURVEY!"
    puts "Associated Questions:"
    survey.questions.each_with_index do |question, index|
      puts " #{index + 1}. #{question.question}"
      question.responses.each_with_index do |response, index|
        puts "  #{index + 1}. #{response.response}"
      end
    end
  end
end

def edit_survey
  list_surveys
  puts "Which survey do you want to update/continue with?"
  survey_choice = gets.chomp.to_i - 1
  @current_survey = Survey.all[survey_choice]
  puts "What would you like to do?"
  puts "[A] Add questions to this survey"
  puts "[E] Edit questions already part of this survey"
  puts "[X] Exit this menu"
  case gets.chomp.upcase
  when "A"
    create_questions
  when "E"
    puts "Which question would you like to edit?"
    list_questions
    selection = gets.chomp.to_i - 1
    @current_question = @current_survey.questions[selection]
    create_responses
  when "X"
    maker_menu
  end
end

def list_questions
  puts "Here are the questions for your current survey:"
  @current_survey.questions.each_with_index do |question, index|
    puts "#{index + 1} #{question.question}"
  end
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
    0.upto(3) do
      new_response = Response.create({response: gets.chomp})
      Choice.create({question_id: Question.all.last.id, response_id: new_response.id})
    end
  elsif current_question_kind == 'Y/N'
    new_response = Response.create({response: 'Yes'})
    new_response1 = Response.create({response: 'No'})
    Choice.create({question_id: Question.all.last.id, response_id: new_response.id})
    Choice.create({question_id: Question.all.last.id, response_id: new_response1.id})
  elsif current_question_kind == 'true/false'
    new_response = Response.create({response: 'True'})
    new_response1 = Response.create({response: 'False'})
    Choice.create({question_id: Question.all.last.id, response_id: new_response.id})
    Choice.create({question_id: Question.all.last.id, response_id: new_response1.id})
  end

  #   0.upto(3) { Question.all.last.responses << Response.create({response: gets.chomp}) }
  # elsif current_question_kind == 'Y/N'
  #   Question.all.last.responses << Response.create({response: 'Yes'})
  #   Question.all.last.responses << Response.create({response: 'No'})
  # elsif current_question_kind == 'true/false'
  #   Question.all.last.responses << Response.create({response: 'True'})
  #   Question.all.last.responses << Response.create({response: 'False'})
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
  when "X"
    maker_menu
  else
    invalid
    maker_menu
  end
end

def show_question_types
  types = ['multiple choice', 'Y/N', 'true/false', 'other']
end

welcome
