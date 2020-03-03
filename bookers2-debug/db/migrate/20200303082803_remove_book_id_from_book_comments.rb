class RemoveBookIdFromBookComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :book_comments, :BookId, :integer
  end
end
