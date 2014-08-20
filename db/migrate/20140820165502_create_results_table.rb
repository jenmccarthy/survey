class CreateResultsTable < ActiveRecord::Migration
  def change
    create_table :results_tables do |t|
      t.column :name, :string

      t.timestamps
    end
  end
end
