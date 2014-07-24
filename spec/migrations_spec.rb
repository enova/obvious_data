require 'spec_helper'
require 'rake'

describe ObviousData::SchemaMethods do
  after{ reset_db! }

  let(:migration){ ActiveRecord::Migration.new }

  describe '#execute_function_files' do
    it 'executes specified functions from the db/functions/ dir' do
      expect{ select_function(:one) }.to raise_error

      migration.execute_function_files('one', 'two')
      expect( select_function(:one) ).to eq( {'one' => '1'} )
      expect( select_function(:two) ).to eq( {'two' => '2'} )
    end
  end

  describe '#execute_view_files' do
    it 'executes specified views from the db/views/ dir' do
      expect{ select_view(:one_v) }.to raise_error

      migration.execute_view_files('one_v', 'two_v')
      expect( select_view(:one_v) ).to eq( '1' )
      expect( select_view(:two_v) ).to eq( '2' )
    end
  end

  describe '#execute_trigger_files' do
    it 'executes specified triggers from the db/triggers/ dir' do
      expect(trigger_exists?(:one_t)).to be_falsey
 
      migration.execute_trigger_files('one_t', 'two_t')
      expect(trigger_exists?(:one_t)).to be_truthy
      expect(trigger_exists?(:two_t)).to be_truthy
    end
  end

  def select_function(function)
    ActiveRecord::Base.connection.execute("select * from #{function}()").first
  end

  def select_view(view)
    ActiveRecord::Base.connection.execute("select * from #{view}").first.values.first
  end

  def trigger_exists?(trigger)
    ActiveRecord::Base.connection.execute("select true from pg_trigger where tgname = '#{trigger}'").first
  end

  def reset_db!
    ActiveRecord::Base.connection.execute "drop function if exists one()"
    ActiveRecord::Base.connection.execute "drop function if exists two()"
    ActiveRecord::Base.connection.execute "drop view if exists one_v"
    ActiveRecord::Base.connection.execute "drop view if exists two_v"
    ActiveRecord::Base.connection.execute "drop trigger if exists one_t on dummy"
    ActiveRecord::Base.connection.execute "drop trigger if exists two_t on dummy"
  end
end
