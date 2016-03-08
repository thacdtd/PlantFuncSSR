class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.integer  "family_id"
      t.string :name
      t.string :image
      t.string :description

      t.timestamps null: false
    end
    add_foreign_key :species, :families
  end
end
