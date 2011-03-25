class CreateIterations < ActiveRecord::Migration
  def self.up
    create_table :iterations do |t|
      t.belongs_to :sprint
      t.integer :number

      t.timestamps
    end
  end

  def self.down
    drop_table :iterations
  end
end
