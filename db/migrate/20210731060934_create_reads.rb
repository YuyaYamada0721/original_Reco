class CreateReads < ActiveRecord::Migration[5.2]
  def change
    create_table :reads do |t|
      t.references :member, foreign_key: true, null: false
      t.references :message, foreign_key: true, null: false
      t.boolean :is_checked, null: false, default: false

      t.timestamps
    end
    add_index :reads, %i[member_id message_id], unique: 'true'
  end
end
