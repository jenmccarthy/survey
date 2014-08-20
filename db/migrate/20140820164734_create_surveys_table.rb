class CreateSurveysTable < ActiveRecord::Migration
  def change
    create_table :surveys_tables do |t|
      t.column :name, :string
      t.column :result_id, :int

      t.timestamps
    end
  end
end
