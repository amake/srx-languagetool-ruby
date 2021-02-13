# frozen_string_literal: true

require 'test_helper'

module Srx
  class LanguagetoolTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Srx::Languagetool::VERSION
    end

    def test_languagetool
      refute_nil(Data.languagetool)
    end

    def test_chinese
      assert_equal(
        ['这是一个测试的句子。', '这也是一个测试的句子。'],
        segment(text: '这是一个测试的句子。这也是一个测试的句子。', language: 'zh')
      )
    end
  end
end
