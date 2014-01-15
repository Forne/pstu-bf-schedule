class CreateAuditoriums < ActiveRecord::Migration
  def change
    create_table :auditoriums do |t|
      t.string :name, null: false
      t.string :shot_name
      t.integer :university_id, null: false, index: true

      t.timestamps
    end
  end
end
