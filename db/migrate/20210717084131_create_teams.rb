class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :owner_id, null: false
      t.string :name, null: false
      t.boolean :is_solo, default: false, null: false

      t.timestamps
    end
  end
end
