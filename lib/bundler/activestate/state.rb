# frozen_string_literal: true

require "open3"

module ActiveState
  module State
    # rubocop:disable Style/ClassVars
    @@state_bin ||= ENV["PATH"].split(":")
                               .map { |path| File.join(path, "state") }
                               .find { |path| File.exist?(path) }
    # rubocop:enable Style/ClassVars

    def state(cmd, *args)
      native(@@state_bin, cmd, args)
    end

    # Execute a native state CLI command.
    #
    # binary - The name (and path) of the native state CLI binary
    # cmd - The name of the native state CLI command as a Symbol.
    # args - Arguments passed on the command line.
    #
    # Examples
    #   native('/bin/state', :install, "NAME@VERSION")
    #
    # Returns a [exitstatus, stdout, stderr] tuple.
    #   The exitstatus is an integer that was the process's exit
    #   status. The out and err elements are the data written to stdout and
    #   stderr as Strings
    def native(binary, cmd, *args)
      exit_status = nil
      stdout, stderr = nil
      cmd = [binary, cmd.to_s, args].join(" ")
      Open3.popen2e(cmd) do |stdin, stdout_stderr, wait_thread|
        stdin.close_write
        Thread.new do
          stdout_stderr.each do |line|
            print line
          # rubocop:disable Lint/SuppressedException
          rescue IOError
          end
          # rubocop:enable Lint/SuppressedException
        end
        exit_status = wait_thread.value
      end
      [exit_status.exitstatus, stdout, stderr]
    end
  end
end
