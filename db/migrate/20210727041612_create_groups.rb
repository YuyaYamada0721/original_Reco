class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.boolean :is_dm, null: false, default: false

      t.timestamps
    end
  end
end
