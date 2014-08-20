class ChangeResponsesQuestions < ActiveRecord::Migration
  def change
    rename_table :responses_questions, :questions_responses
  end
end
