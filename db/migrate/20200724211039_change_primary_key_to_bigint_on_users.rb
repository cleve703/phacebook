class ChangePrimaryKeyToBigintOnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :id, :bigint
  end
end
