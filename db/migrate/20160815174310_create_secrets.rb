class CreateSecrets < ActiveRecord::Migration
  def change
    create_table :secrets do |t|
      t.text :content
      t.string :user_references

      t.timestamps null: false
    end
  end
end
