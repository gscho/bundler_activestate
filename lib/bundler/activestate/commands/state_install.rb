# frozen_string_literal: true

module ActiveState
  module Command
    class StateInstall < ActiveState::Command::Base
      command "state-install"

      def exec(_command, _args)
        lock_and_import!
      end
    end
  end
end
