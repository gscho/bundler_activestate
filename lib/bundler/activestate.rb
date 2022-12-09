# frozen_string_literal: true

require_relative "activestate/version"
require_relative "activestate/state"
require_relative "activestate/command"

module ActiveState
  class ActiveStateError < StandardError; end
end
