# This migration comes from wow_engine (originally 20140504020048)
class WowAddLastSyncedAtToRealms < ActiveRecord::Migration
  def change
    add_column :wow_realms, :last_checked_at, :timestamp
    add_column :wow_realms, :last_synced_at, :timestamp
  end
end
