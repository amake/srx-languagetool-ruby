# frozen_string_literal: true

require 'srx'
require_relative 'languagetool/version'

module Srx
  class Data
    class << self
      # LanguageTool SRX rules
      #
      # @return [Data]
      def languagetool
        from_file(path: File.expand_path('segment.srx', __dir__))
      end
    end
  end
end
