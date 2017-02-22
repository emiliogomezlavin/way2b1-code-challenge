class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :bio
      t.integer :public_repos
      t.integer :followers
      t.integer :following
      t.string :profile_pic

      t.timestamps
    end
  end
end
