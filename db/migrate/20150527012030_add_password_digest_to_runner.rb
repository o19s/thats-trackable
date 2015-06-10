class AddPasswordDigestToRunner < ActiveRecord::Migration
  def change
    add_column :runners, :password_digest, :string
  end
end
