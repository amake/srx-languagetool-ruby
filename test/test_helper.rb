# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'srx/languagetool'

require 'minitest/autorun'

def languagetool_engine(*args, **kwargs)
  Srx::Engine.new(Srx::Data.languagetool, *args, **kwargs)
end

def segment(text:, language:, **_kwargs)
  languagetool_engine.segment(text, language: language).map(&:strip)
end
