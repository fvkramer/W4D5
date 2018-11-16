class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title
      t.string :body
      t.date :target_date

      t.timestamps
    end
  end
end
