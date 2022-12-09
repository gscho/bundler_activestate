# frozen_string_literal: true

module ActiveState
  module Command
    class StateRemove < Bundler::Plugin::API
      include ActiveState::State

      command "state-remove"

      def exec(_command, args)
        require "bundler/cli/remove"

        Bundler::CLI::Remove.new(args, { "install" => false }).run
        lock_and_import!
      end
    end
  end
end
