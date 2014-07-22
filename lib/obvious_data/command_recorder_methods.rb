module ObviousData::CommandRecorderMethods
  def execute_function_files(*args)
    record(:execute_function_files, args)
  end

  def invert_execute_function_files(args)
    # FIXME
    []
  end
end
