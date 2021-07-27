class CreateGroupMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_members do |t|
      t.reference :member, null: false
      t.reference :group, null: false

      t.timestamps
    end
  end
end
