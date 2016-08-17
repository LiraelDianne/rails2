class ChangeUserReferenceinSecrets < ActiveRecord::Migration
  def change
  	remove_column :secrets, :user_references
  	add_reference :secrets, :user, foreign_key: true
  end
end
