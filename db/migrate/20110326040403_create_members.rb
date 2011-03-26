class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.belongs_to :team
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
