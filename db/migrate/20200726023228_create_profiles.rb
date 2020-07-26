class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :home_town
      t.string :employer
      t.string :college

      t.timestamps
    end
  end
end
