# This migration comes from wow_engine (originally 20140503173235)
class CreateWowRealms < ActiveRecord::Migration
  def change
    create_table :wow_realms do |t|
      t.string :slug
      t.string :name

      t.timestamps
    end
  end
end
