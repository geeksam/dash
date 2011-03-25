class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.belongs_to :team
      t.integer :number
      t.date :starts_on
      t.date :ends_on

      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
