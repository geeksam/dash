class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.belongs_to :iteration
      t.string :name
      t.string :result
      t.string :what
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :goals
  end
end
