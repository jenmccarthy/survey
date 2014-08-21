class CreateChoicesResults < ActiveRecord::Migration
  def change
    create_table :choices_results do |t|
      t.column :result_id, :integer
      t.column :choice_id, :integer

      t.timestamps
    end
  end
end
