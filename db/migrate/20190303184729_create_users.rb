class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :external_id
      t.string :name
      t.string :alias
      t.boolean :active
      t.boolean :verified
      t.boolean :shared
      t.string :locale
      t.string :timezone
      t.datetime :last_login_at
      t.string :email
      t.string :phone
      t.string :signature
      t.references :organization, foreign_key: true
      t.boolean :suspended
      t.string :role

      t.timestamps
    end
  end
end
