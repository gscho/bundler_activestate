# frozen_string_literal: true

module ActiveState
  module Command
    class StateRemove < ActiveState::Command::Base
      command "state-remove"

      def exec(_command, args)
        require "bundler/injector"
        raise InvalidOption, "Please specify gems to remove." if args.empty?

        gem_name = args.delete_at 0
        opts = parse_global_opts
        Bundler::Injector.remove([gem_name], {})
        lock_and_import!(opts)
      end
    end
  end
end
