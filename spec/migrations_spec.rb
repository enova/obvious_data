require 'spec_helper'
require 'rake'

describe ObviousData::SchemaMethods do
  let(:migration){ ActiveRecord::Migration.new }

  describe '#execute_function_files' do
    it 'executes specified functions from the db/functions/ dir' do
      reset_db!
      expect{ select_function(:one) }.to raise_error

      migration.execute_function_files('one', 'two')
      expect( select_function(:one) ).to eq( {'one' => '1'} )
      expect( select_function(:two) ).to eq( {'two' => '2'} )
    end
  end

  describe '#execute_view_files' do
    it 'executes specified functions from the db/views/ dir' do
      reset_db!
      expect{ select_view(:one_v) }.to raise_error

      migration.execute_view_files('one_v', 'two_v')
      expect( select_view(:one_v) ).to eq( '1' )
      expect( select_view(:two_v) ).to eq( '2' )
    end
  end

  def select_function(function)
    ActiveRecord::Base.connection.execute("select * from #{function}()").first
  end

  def select_view(view)
    ActiveRecord::Base.connection.execute("select * from #{view}").first.values.first
  end

  def reset_db!
    `bundle exec rake app:db:test:prepare`
  end
end
