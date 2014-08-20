class CreateResponsesQuestions < ActiveRecord::Migration
  def change
    create_table :responses_questions do |t|
      t.column :response_id, :int
      t.column :question_id, :int

      t.timestamps
    end
  end
end
