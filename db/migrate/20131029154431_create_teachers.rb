class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :full_name, null: false
      t.string :first_name
      t.string :last_name
      t.string :patronymic_name
      t.integer :sex
      t.date :bdate
      t.integer :university_id, null: false, index: true

      t.timestamps
    end
  end
end
