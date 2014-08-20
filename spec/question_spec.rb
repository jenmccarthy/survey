require 'spec_helper'

describe Question do
  it "will have many associated surveys" do
    test_question = Question.create({question: 'How do you get to work?', kind: 'multiple choice'})
    test_survey1 = Survey.create({name: 'Work'})
    test_survey2 = Survey.create({name: 'Transportation'})
    test_question.surveys << test_survey1
    test_question.surveys << test_survey2
    expect(test_question.surveys).to eq [test_survey1, test_survey2]
  end

  it { should have_and_belong_to_many :responses }
end
