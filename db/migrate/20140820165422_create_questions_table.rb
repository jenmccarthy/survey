class CreateQuestionsTable < ActiveRecord::Migration
  def change
    create_table :questions_tables do |t|
      t.column :question, :string
      t.column :type, :string
      t.column :result_id, :int

      t.timestamps
    end
  end
end
