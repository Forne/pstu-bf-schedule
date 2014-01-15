class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.integer :group_id, null: false
      t.integer :teacher_id, null: false
      t.integer :type_id
      t.integer :subject_id, null: false
      t.integer :auditorium_id
    end
  end
end
