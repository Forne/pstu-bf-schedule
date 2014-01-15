class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :university_id
      t.integer :form_id
      t.integer :start_year
      t.integer :end_year
      t.string :parse_name
      t.boolean :archive

      t.timestamps

      t.index [:name, :university_id], unique: true
    end
  end
end
