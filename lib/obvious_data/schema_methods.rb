module ObviousData::SchemaMethods
  def execute_function_files(*functions)
    functions.each do |function|
      path = Rails.root.join('db', 'functions', "#{function}.sql")
      execute(File.read(path))
    end
  end
end
