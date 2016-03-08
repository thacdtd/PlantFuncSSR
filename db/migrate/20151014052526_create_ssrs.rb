class CreateSsrs < ActiveRecord::Migration
  def change
    create_table :ssrs do |t|
      t.integer  "species_id"
      t.string :SSR_ID
      t.integer :SSR_nr
      t.string :SSR_type
      t.string :SSR, limit: 1000
      t.integer :size
      t.integer :start
      t.integer :end
      
      t.string :Forward1
      t.string :Reverse1
      t.float :FP_Tm1
      t.integer :FP_Size1
      t.float :RP_Tm1
      t.integer :RP_Size1
      t.integer :Product_Size1
      t.integer :Start1
      t.integer :End1
      
      t.string :Forward2
      t.string :Reverse2
      t.float :FP_Tm2
      t.integer :FP_Size2
      t.float :RP_Tm2
      t.integer :RP_Size2
      t.integer :Product_Size2
      t.integer :Start2
      t.integer :End2
      
      t.string :Forward3
      t.string :Reverse3
      t.float :FP_Tm3
      t.integer :FP_Size3
      t.float :RP_Tm3
      t.integer :RP_Size3
      t.integer :Product_Size3
      t.integer :Start3
      t.integer :End3
      
      t.boolean :has_annotation

      t.timestamps null: false
    end
    add_foreign_key :ssrs, :species
  end
end
