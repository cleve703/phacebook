class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :inviter, null: false, foreign_key: {to_table: :users}, index: true
      t.references :invitee, null: false, foreign_key: {to_table: :users}, index: true
      t.boolean :confirmed, default: false

      t.timestamps
    end
  end
end
