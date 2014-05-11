# This migration comes from wow_engine (originally 20140510211921)
class AddStatusToAuction < ActiveRecord::Migration
  def change
    add_column :wow_auctions, :status, :string, default: 'in_progress'
    add_index :wow_auctions, :status
  end
end
