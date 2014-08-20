class FixTableNames < ActiveRecord::Migration
  def change
    rename_table :surveys_tables, :surveys
    rename_table :questions_tables, :questions
    rename_table :responses_tables, :responses
    rename_table :results_tables, :results
  end
end
