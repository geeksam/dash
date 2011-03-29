class AddStatusToGoal < ActiveRecord::Migration
  def self.up
    add_column :goals, :status, :string
    remove_column :goals, :nop
    remove_column :goals, :achieved
  end

  def self.down
    remove_column :goals, :status
    add_column :goals, :nop, :boolean
    add_column :goals, :achieved, :boolean
  end
end
