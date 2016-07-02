require 'active_record/railtie'

module ObviousData
  class Railtie < ::Rails::Railtie
    initializer 'obvious_data' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::ConnectionAdapters::AbstractAdapter.include ObviousData::SchemaMethods
        ActiveRecord::Migration::CommandRecorder.include ObviousData::CommandRecorderMethods
      end
    end
  end
end
