class AddCountWordsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :count_words, :integer
  end
end
