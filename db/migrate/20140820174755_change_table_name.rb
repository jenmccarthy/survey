class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :surveys_questions, :questions_surveys
  end
end
