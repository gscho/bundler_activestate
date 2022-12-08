# frozen_string_literal: true

require_relative "activestate/version"
require_relative "activestate/state"
require "open3"
require "bundler/cli/add"
require "bundler/cli/lock"
require "bundler/cli/remove"

module ActiveState
  class ActiveStateError < StandardError; end
  class StateInstallCommand < Bundler::Plugin::API
    include ActiveState::State
    # Register this class as a handler for the `my_command` command
    command "state-install"

    # The exec method will be called with the `command` and the `args`.
    # This is where you should handle all logic and functionality
    def exec(command, args)
      options = {
        local: false,
        print: false,
        lockfile: nil,
        "full-index" => false,
        "add-platform" => [],
        "remove-platform" => [],
      }
      Bundler::CLI::Lock.new(options).run
      puts state(:import, "Gemfile.lock")
    end
  end
  class StateAddCommand < Bundler::Plugin::API
    include ActiveState::State
    # Register this class as a handler for the `my_command` command
    command "state-add"

    # The exec method will be called with the `command` and the `args`.
    # This is where you should handle all logic and functionality
    def exec(command, args)
      options = {
        "skip-install" => true,
      }
      Bundler::CLI::Add.new(options, args).run
      options = {
        local: false,
        print: false,
        lockfile: nil,
        "full-index" => false,
        "add-platform" => [],
        "remove-platform" => [],
      }
      Bundler::CLI::Lock.new(options).run
      puts state(:import, "Gemfile.lock")
    end
  end
  class StateRemoveCommand < Bundler::Plugin::API
    include ActiveState::State
    # Register this class as a handler for the `my_command` command
    command "state-remove"

    # The exec method will be called with the `command` and the `args`.
    # This is where you should handle all logic and functionality
    def exec(command, args)
      options = {
        "install" => false,
      }
      Bundler::CLI::Remove.new(args, options).run
      options = {
        local: false,
        print: false,
        lockfile: nil,
        "full-index" => false,
        "add-platform" => [],
        "remove-platform" => [],
      }
      Bundler::CLI::Lock.new(options).run
      puts state(:import, "Gemfile.lock")
    end
  end
end