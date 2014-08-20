class ChangeQuestionsTableColumnType < ActiveRecord::Migration
  def change
    change_table :questions do |t|
      t.rename :type, :kind
    end
  end
end
