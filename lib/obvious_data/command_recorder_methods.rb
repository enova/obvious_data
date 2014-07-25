# At present no obvious_data helpers are auto-invertible. We can't just drop a function
# executed via #execute_function_file cause that helper is _also_ used to update existing
# functions. Might address that later.
module ObviousData::CommandRecorderMethods
  def execute_function_file(*args)
    record(:execute_function_files, args)
  end

  def drop_function(*args)
    record(:drop_function, args)
  end

  def execute_view_file(*args)
    record(:execute_view_file, args)
  end

  def drop_view(*args)
    record(:drop_view, args)
  end

  def execute_trigger_file(*args)
    record(:execute_trigger_file, args)
  end

  def drop_trigger(*args)
    record(:drop_trigger, args)
  end
end
