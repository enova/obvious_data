module ObviousData::SchemaMethods
  def execute_function_files(*functions)
    functions.each do |function|
      path = Rails.root.join('db', 'functions', "#{function}.sql")
      execute(File.read(path))
    end
  end

  def execute_view_files(*views)
    views.each do |view|
      path = Rails.root.join('db', 'views', "#{view}.sql")
      execute(File.read(path))
    end
  end

  def execute_trigger_files(*triggers)
    triggers.each do |trigger|
      path = Rails.root.join('db', 'triggers', "#{trigger}.sql")
      execute(File.read(path))
    end
  end
end
