# frozen_string_literal: true

module ActiveState
  module Command
    class StateRemove < ActiveState::Command::Base
      command "state-remove"

      def exec(_command, args)
        require "bundler/injector"
        raise InvalidOption, "Please specify gems to remove." if args.empty?
        
        Bundler::Injector.remove(args, {})
        lock_and_import!
      end
    end
  end
end
