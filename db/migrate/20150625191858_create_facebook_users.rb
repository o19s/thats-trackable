class CreateFacebookUsers < ActiveRecord::Migration
  def change
    create_table :facebook_users do |t|
      t.string :name
      t.string :uid
      t.string :avatar_url
      t.references :runner, index: true

      t.timestamps null: false
    end
    add_foreign_key :facebook_users, :runners
  end
end
