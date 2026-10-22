class AddCanCreateBoardsToUsers < ActiveRecord::Migration[8.2]
  def change
    add_column :users, :can_create_boards, :boolean, default: true, null: false
  end
end
