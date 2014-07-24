class ObviousDataDirectoriesGenerator < Rails::Generators::Base
  def create_obvious_data_directories
    empty_directory "db/functions"
    empty_directory "db/triggers"
    empty_directory "db/views"
  end
end
