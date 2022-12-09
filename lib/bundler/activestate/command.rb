# frozen_string_literal: true

require_relative "commands/state_install"
require_relative "commands/state_add"
require_relative "commands/state_remove"

module ActiveState
  module Command
    def lock_and_import!(gemfile_lock = "Gemfile.lock")
      require "bundler/cli/lock"

      Bundler::CLI::Lock.new({
                               local: false,
                               print: false,
                               lockfile: nil,
                               "full-index" => false,
                               "add-platform" => [],
                               "remove-platform" => []
                             }).run
      state(:import, gemfile_lock)
    end
  end
end
