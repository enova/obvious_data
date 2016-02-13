require 'spec_helper'
require 'rake'

RSpec.describe ObviousData::SchemaMethods do
  after{ reset_db! }
  before(:context){ add_sql_sources }
  after(:context){ remove_sql_sources }

  let(:migration){ ActiveRecord::Migration.new }

  describe '#execute_function_file' do
    it 'executes specified function from the db/functions/ dir' do
      expect{ select_function(:one) }.to raise_error(/PG::UndefinedFunction/)

      migration.execute_function_file('one')
      expect( select_function(:one) ).to eq( {'one' => '1'} )
    end
  end

  describe '#drop_function' do
    it 'drops the specified function' do
      migration.execute_function_file('one')
      expect( select_function(:one) ).to eq( {'one' => '1'} )

      migration.drop_function('one()')
      expect{ select_function(:one) }.to raise_error(/PG::UndefinedFunction/)
    end
  end

  describe '#execute_view_file' do
    it 'executes specified view from the db/views/ dir' do
      expect{ select_view(:one_v) }.to raise_error(/PG::UndefinedTable/)

      migration.execute_view_file('one_v')
      expect( select_view(:one_v) ).to eq( '1' )
    end
  end

  describe '#drop_view' do
    it 'drops the specified view' do
      migration.execute_view_file('one_v')
      expect( select_view(:one_v) ).to eq( '1' )

      migration.drop_view('one_v')
      expect{ select_view(:one_v) }.to raise_error(/PG::UndefinedTable/)
    end
  end

  describe '#execute_trigger_file' do
    it 'executes specified trigger from the db/triggers/ dir' do
      expect(trigger_exists?(:one_t)).to be_falsey
 
      migration.execute_trigger_file('one_t')
      expect(trigger_exists?(:one_t)).to be_truthy
    end
  end

  describe '#drop_trigger' do
    it 'drops the specified trigger on the specified table' do
      migration.execute_trigger_file('one_t')
      expect(trigger_exists?(:one_t)).to be_truthy

      migration.drop_trigger('one_t', 'dummy')
      expect(trigger_exists?(:one_t)).to be_falsey
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
    ActiveRecord::Base.connection.execute "drop view if exists one_v"
    ActiveRecord::Base.connection.execute "drop trigger if exists one_t on dummy"
  end

  def add_sql_sources
    %w[functions triggers views].each do |dir|
      FileUtils.copy_entry(File.join(sql_sources_root, dir), File.join(sql_sources_target, dir))
    end
  end

  def remove_sql_sources
    %w[functions triggers views].each do |dir|
      FileUtils.rm_rf(File.join(sql_sources_target, dir))
    end
  end

  def sql_sources_root
    "#{File.dirname(__FILE__)}/support/db/"
  end

  def sql_sources_target
    "#{File.dirname(__FILE__)}/dummy/db/"
  end
end
