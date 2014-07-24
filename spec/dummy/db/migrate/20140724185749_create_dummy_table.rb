class CreateDummyTable < ActiveRecord::Migration
  def up
    create_table :dummy
  end

  def down
  end
end
