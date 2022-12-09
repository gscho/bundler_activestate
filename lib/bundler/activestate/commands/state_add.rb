# frozen_string_literal: true

module ActiveState
  module Command
    class StateAdd < ActiveState::Command::Base
      command "state-add"

      def exec(_command, args)
        require "bundler/cli/add"

        Bundler::CLI::Add.new({ "skip-install" => true }, args).run
        lock_and_import!
      end
    end
  end
end
