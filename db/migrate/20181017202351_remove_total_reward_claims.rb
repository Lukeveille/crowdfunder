class RemoveTotalRewardClaims < ActiveRecord::Migration[5.2]
  def change
    remove_column :rewards, :total_claims
  end
end
