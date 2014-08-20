class FixResponsesAttribute < ActiveRecord::Migration
  def change
    change_table :responses do |t|
      t.rename :reponse, :response
    end
  end
end
