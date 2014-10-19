class CreateEuRels < ActiveRecord::Migration
  def change
    create_table :eu_rels do |t|
      t.integer :attender_id
      t.integer :attended_id

      t.timestamps
    end
    add_index :eu_rels, :attender_id
    add_index :eu_rels, :attended_id
    add_index :eu_rels, [:attender_id, :attended_id], unique: true
  end
end
