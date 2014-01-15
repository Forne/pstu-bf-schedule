class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name, null: false, unique: true

      t.timestamps
    end
  end
end
