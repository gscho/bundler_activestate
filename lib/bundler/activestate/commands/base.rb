# frozen_string_literal: true

module ActiveState
  module Command
    class Base < Bundler::Plugin::API
      include ActiveState::State

      def parse_global_opts
        options = {
          force: true,
          push: false,
          gemfile_lock: "Gemfile.lock",
        }
        OptionParser.new do |opts|
          opts.on("-f", "--[no-]force [FLAG]", TrueClass, "Force a state import") do |f|
            options[:force] = f.nil? ? true : f
          end
          opts.on("-p", "--[no-]push [FLAG]", TrueClass, "Push your latest changes to platform.activestate.com") do |f|
            options[:push] = f.nil? ? true : f
          end
        end.parse!
        options
      end

      def lock_and_import!(opts)
        require "bundler/cli/lock"

        Bundler::CLI::Lock.new({
                                 local: false,
                                 print: false,
                                 lockfile: nil,
                                 "full-index" => false,
                                 "add-platform" => [],
                                 "remove-platform" => []
                               }).run
        args = opts[:gemfile_lock].dup
        args << " --force" if opts[:force]
        state(:import, args)
        state(:push) if opts[:push]
      end
    end
  end
end
