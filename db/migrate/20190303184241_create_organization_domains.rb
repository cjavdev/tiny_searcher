class CreateOrganizationDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :organization_domains do |t|
      t.string :name, null: false
      t.references :organization, foreign_key: true

      t.timestamps
    end

    add_index :organization_domains, :name
    add_index :organization_domains, [:organization_id, :name], unique: true
  end
end
