class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :group_id, index: true
      t.integer :sex, :default => 0
      t.date :birthday
      t.integer :vk_id, null: false, index: true, unique: true
      t.boolean :vk_has_mobile, index: true

      t.boolean :is_banned, null: false, :default => false
      t.boolean :is_manager, null: false, :default => false

      t.timestamps
    end
  end
end
