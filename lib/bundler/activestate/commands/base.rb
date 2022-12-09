# frozen_string_literal: true

module ActiveState
  module Command
    class Base < Bundler::Plugin::API
      include ActiveState::State

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
end
