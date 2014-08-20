class CreateResponsesTable < ActiveRecord::Migration
  def change
    create_table :responses_tables do |t|
      t.column :reponse, :string
      t.column :result_id, :integer

      t.timestamps
    end
  end
end
