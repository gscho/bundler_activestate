module ActiveState
	module State
	  # rubocop:disable Style/ClassVars
	  @@state_bin ||= ENV['PATH'].split(':')
	                             .map { |path| File.join(path, 'state') }
	                             .find { |path| File.exist?(path) }
	  # rubocop:enable Style/ClassVars
	  
	  def state(cmd, *args)
	    native(@@state_bin, cmd, args)
	  end

	  # Execute a native state CLI command.
	  #
	  # binary - The name (and path) of the native state CLI binary
	  # cmd - The name of the native state CLI command as a Symbol.
	  # options - Command line option arguments passed to the native state CLI command.
	  #   Single char keys are converted to short options (:a => -a).
	  #   Multi-char keys are converted to long options (:arg => '--arg').
	  #   Underscores in keys are converted to dashes. These special options
	  #   are used to control command execution and are not passed in command
	  #   invocation:
	  #     :timeout - Maximum amount of time the command can run for before
	  #       being aborted.
	  #     :env - Hash of environment variable key/values that are set on the
	  #       child process.
	  # args - Non-option arguments passed on the command line.
	  #
	  # Examples
	  #   native('/bin/state', :install, "NAME@VERSION")
	  #
	  # Returns a [exitstatus, out, err] tuple.
	  #   The exitstatus is an small integer that was the process's exit
	  #   status. The out and err elements are the data written to stdout and
	  #   stderr as Strings
	  def native(binary, cmd, *args)
      exit_status = 0
      stdout, stderr = nil
      cmd = [binary, cmd.to_s, args].join(" ")
      Open3.popen2e(cmd) do |stdin, stdout_stderr, wait_thread|
        stdin.close_write
        Thread.new do
          stdout_stderr.each { |l| print l }
        end
        exit_status = wait_thread.value
      end
      [exit_status.exitstatus, stdout, stderr]
    end
	end
end