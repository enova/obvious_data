module ObviousData::SchemaMethods
  def execute_function_file(function)
    path = Rails.root.join('db', 'functions', "#{function}.sql")
    execute(File.read(path))
  end

  def drop_function(signature)
    execute "DROP FUNCTION IF EXISTS #{signature};"
  end

  def execute_view_file(view)
    path = Rails.root.join('db', 'views', "#{view}.sql")
    execute(File.read(path))
  end

  def drop_view(signature)
    execute "DROP VIEW IF EXISTS #{signature};"
  end

  def execute_trigger_file(trigger)
    path = Rails.root.join('db', 'triggers', "#{trigger}.sql")
    execute(File.read(path))
  end

  def drop_trigger(trigger, table)
    execute "DROP TRIGGER IF EXISTS #{trigger} ON #{table};"
  end
end
