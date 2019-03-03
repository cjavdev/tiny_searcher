class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :external_id
      t.string :ticket_type
      t.string :subject
      t.text :description
      t.string :priority
      t.string :status
      t.integer :submitter_id, index: true
      t.integer :assignee_id, index: true
      t.integer :organization_id, index: true
      t.boolean :has_incidents
      t.datetime :due_at
      t.string :via

      t.timestamps
    end

    add_index :tickets, :external_id
    add_index :tickets, :ticket_type
    add_index :tickets, :status
    add_index :tickets, :priority
  end
end
