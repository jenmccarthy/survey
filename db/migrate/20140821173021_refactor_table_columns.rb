class RefactorTableColumns < ActiveRecord::Migration
  def change
    rename_table :questions_responses, :choices
    remove_column :results, :name
    add_column :results, :choice_id, :integer
  end
end
