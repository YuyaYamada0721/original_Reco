class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.references :member, foreign_key: true, null: false
      t.references :knowledge, foreign_key: true, null: false

      t.timestamps
    end
    add_index :stocks, %i[member_id knowledge_id], unique: 'true'
  end
end
