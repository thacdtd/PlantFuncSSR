class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :species_id
      t.integer :Num_Seqs_Exam
      t.integer :Size_Exam_Seqs
      t.integer :Num_SSR_Indent
      t.integer :SSR_Cont_Seqs
      t.integer :Seqs_Cont_SSR
      t.integer :Num_SSR_Present
      t.integer :Mono
      t.integer :Di
      t.integer :Tri
      t.integer :Tetra
      t.integer :Penta
      t.integer :Hexa
      t.integer :Complex
      t.integer :Compound

      t.timestamps null: false
    end
    add_foreign_key :statistics, :species
  end
end
