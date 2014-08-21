class FixEverything < ActiveRecord::Migration
  def change
    change_table :questions do |t|
      t.remove :result_id
    end
    change_table :responses do |t|
      t.remove :result_id
    end
    change_table :results do |t|
      t.rename :choice_id, :survey_id
    end
    change_table :surveys do |t|
      t.remove :result_id
    end
  end
end
