class CreateGoalsReally < ActiveRecord::Migration
  def self.up
    create_table :goals, :force => true do |t|
      t.belongs_to :member
      t.belongs_to :iteration
      t.string :result
      t.boolean :nop
      t.boolean :achieved
      t.text :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :goals
  end
end
