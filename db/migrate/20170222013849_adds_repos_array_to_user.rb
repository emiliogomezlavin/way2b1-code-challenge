class AddsReposArrayToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :repos_array, :text, array: true, default: []
  end
end
