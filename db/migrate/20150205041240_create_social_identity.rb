class CreateSocialIdentity < ActiveRecord::Migration
  def change
    create_table :social_identities do |t|
      t.string :provider
      t.string :email
      t.string :username
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :auth_token
      t.integer :user_id

      t.timestamps
    end
  end
end
