class CreateTeacherNames < ActiveRecord::Migration
  def change
    create_table :teacher_names do |t|
      t.string :name, null: false
      t.integer :teacher_id, null: false, index: true

      t.integer :university_id

      t.timestamps

      t.index [:name, :university_id], unique: true
    end
  end
end
