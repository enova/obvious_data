require 'active_record/railtie'

module ObviousData
  class Railtie < ::Rails::Railtie
    initializer 'obvious_data' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::ConnectionAdapters::AbstractAdapter.class_eval do
          include ObviousData::SchemaMethods
        end

        ActiveRecord::Migration::CommandRecorder.class_eval do
          include ObviousData::CommandRecorderMethods
        end
      end
    end
  end
end
