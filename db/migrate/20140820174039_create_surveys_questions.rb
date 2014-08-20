class CreateSurveysQuestions < ActiveRecord::Migration
  def change
    create_table :surveys_questions do |t|
      t.column :survey_id, :int
      t.column :question_id, :int

      t.timestamps
    end
  end
end
