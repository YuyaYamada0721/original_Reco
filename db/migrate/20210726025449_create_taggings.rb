class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.references :tip, foreign_key: true, null: false
      t.references :tag, foreign_key: true, null: false

      t.timestamps
    end
    add_index :taggings, %i[tip_id tag_id], unique: 'true'
  end
end
