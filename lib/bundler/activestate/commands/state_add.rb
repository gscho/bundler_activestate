# frozen_string_literal: true

module ActiveState
  module Command
    class StateAdd < ActiveState::Command::Base
      command "state-add"

      def exec(_command, args)
        require "bundler/cli/add"

        gem_name = args.delete_at 0
        opts = parse_global_opts
        Bundler::CLI::Add.new({ "skip-install" => true }, [gem_name]).run
        lock_and_import!(opts)
      end
    end
  end
end
