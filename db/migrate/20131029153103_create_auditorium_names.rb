class CreateAuditoriumNames < ActiveRecord::Migration
  def change
    create_table :auditorium_names do |t|
      t.string :name, null: false
      t.integer :auditorium_id, null: false, index: true

      t.integer :university_id

      t.timestamps

      t.index [:name, :university_id], unique: true
    end
  end
end
