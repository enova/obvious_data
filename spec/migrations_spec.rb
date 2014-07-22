require 'spec_helper'

describe ObviousData::SchemaMethods do
  let(:migration){ ActiveRecord::Migration.new }

  describe '#execute_function_files' do
    it 'executes specified functions from functions/ dir' do
      migration.execute_function_files('one', 'two')
      expect( select_function(:one) ).to eq( {'one' => '1'} )
      expect( select_function(:two) ).to eq( {'two' => '2'} )
    end
  end

  def select_function(function)
    ActiveRecord::Base.connection.execute("select * from #{function}()").first
  end
end
