class CreateTips < ActiveRecord::Migration[5.2]
  def change
    create_table :tips do |t|
      t.references :member, foreign_key: true, null: false
      t.references :knowledge, foreign_key: true, null: false
      t.references :team, foreign_key: true, null: false
      t.string :name, null: false
      t.text :content

      t.timestamps
    end
  end
end
