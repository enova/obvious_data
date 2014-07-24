class CreateDummyTriggerFunc < ActiveRecord::Migration
  def up
    execute "create or replace function do_dummy() returns trigger as $$
              begin
                return null;
              end;
             $$ language plpgsql;"
  end

  def down
  end
end
