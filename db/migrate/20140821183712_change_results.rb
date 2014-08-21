class ChangeResults < ActiveRecord::Migration
  def change
    remove_column :results, :choice_id
    add_column :results, :survey_id, :integer

    remove_column :surveys, :result_id
    remove_column :questions, :result_id
    remove_column :responses, :result_id
  end
end
