require 'spec_helper'

describe Survey do
  it 'will have many questions' do
    test_survey = Survey.create({name: 'Work'})
    test_question = Question.create({question: 'How do you get to work?', kind: 'multiple choice'})
    test_question2 = Question.create({question: 'Do you like your current job?', kind: 'multiple choice'})
    test_survey.questions << test_question
    test_survey.questions << test_question2
    expect(test_survey.questions).to eq [test_question, test_question2]
  end

end
