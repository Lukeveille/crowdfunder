class RewardsCounters < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :limit, :integer, default: 5
    add_column :rewards, :total_claims, :integer, default: 0
  end
end
