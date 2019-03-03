class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
      t.string :name, null: false
      t.references :organization, foreign_key: true

      t.timestamps
    end
    add_index :domains, [:organization_id, :name], unique: true
  end
end
