class CreateGroupMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_members do |t|
      t.references :member, null: false
      t.references :group, null: false

      t.timestamps
    end
  end
end
