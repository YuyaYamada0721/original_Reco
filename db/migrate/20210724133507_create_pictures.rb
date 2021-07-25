class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.references :tip, foreign_key: true, null: false
      t.string :image

      t.timestamps
    end
  end
end
