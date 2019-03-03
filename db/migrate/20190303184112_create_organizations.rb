class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :external_id
      t.string :name
      t.string :details
      t.boolean :shared_tickets

      t.timestamps
    end

    add_index :organizations, :name
    add_index :organizations, :external_id
    add_index :organizations, :shared_tickets
  end
end
