class CreateEntityTypes < ActiveRecord::Migration
  def change
    create_table :entity_types do |t|
      t.string :name, null: false
      t.string :shot_name, null: false
      t.boolean :important, null: false
    end
  end
end
