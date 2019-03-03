class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.references :taggable, polymorphic: true, index: true
      t.string :name, null: false

      t.timestamps
    end

    add_index :tags, [:taggable_id, :taggable_type, :name], unique: true
  end
end
