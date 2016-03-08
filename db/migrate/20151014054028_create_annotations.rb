class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.integer  "species_id"
      t.string :name
      t.string :MPG_name
      t.string :MPG_description
      
      t.string :Goterm, limit: 1000
      t.string :UnitProt, limit: 10000
      t.string :InterPro, limit: 10000

      t.timestamps null: false
    end
    add_foreign_key :annotations, :species
  end
end
