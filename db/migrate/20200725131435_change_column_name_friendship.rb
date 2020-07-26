class ChangeColumnNameFriendship < ActiveRecord::Migration[6.0]
  def change
    rename_column :friendships, :inviter_id, :friender_id
    rename_column :friendships, :invitee_id, :friended_id
  end
end
