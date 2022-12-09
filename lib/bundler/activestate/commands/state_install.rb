# frozen_string_literal: true

module ActiveState
  module Command
    class StateInstall < ActiveState::Command::Base
      command "state-install"

      def exec(_command, _args)
        opts = parse_global_opts
        lock_and_import!(opts)
      end
    end
  end
end
