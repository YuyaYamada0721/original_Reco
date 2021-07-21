class CreateKnowledges < ActiveRecord::Migration[5.2]
  def change
    create_table :knowledges do |t|
      t.references :member, foreign_key: true, null: false
      t.references :team, foreign_key: true, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
