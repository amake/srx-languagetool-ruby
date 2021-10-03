# frozen_string_literal: true

require 'test_helper'

class LanguageToolRulesTest < Minitest::Test
  def test_english
    @lang_code = 'en'

    assert_split("Here's a")
    assert_split("Here's a sentence. ", "And here's one that's not comp")
    assert_split('Or did you install it (i.e. MS Word) yourself?')

    assert_split('This is a sentence. ')
    assert_split('This is a sentence. ', 'And this is another one.')
    assert_split('This is a sentence.', "Isn't it?", 'Yes, it is.')
    assert_split('This is e.g. Mr. Smith, who talks slowly...',
                 'But this is another sentence.')
    assert_split('Chanel no. 5 is blah.')
    assert_split('Mrs. Jones gave Peter $4.5, to buy Chanel No 5.',
                 'He never came back.')
    assert_split("On p. 6 there's nothing. ", 'Another sentence.')
    assert_split('Leave me alone!, he yelled. ', 'Another sentence.')
    assert_split('"Leave me alone!", he yelled.')
    assert_split("'Leave me alone!', he yelled. ", 'Another sentence.')
    assert_split("'Leave me alone!,' he yelled. ", 'Another sentence.')
    assert_split('This works on the phrase level, i.e. not on the word level.')
    assert_split("Let's meet at 5 p.m. in the main street.")
    assert_split('James comes from the U.K. where he worked as a programmer.')
    assert_split("Don't split strings like U.S.A. please.")
    assert_split('Hello ( Hi! ) my name is Chris.')
    assert_split("Don't split strings like U. S. A. either.")
    assert_split("Don't split strings like U.S.A either.")
    assert_split("Don't split... ", 'Well you know. ', 'Here comes more text.')
    assert_split("Don't split... well you know. ", 'Here comes more text.')
    assert_split('The "." should not be a delimiter in quotes.')
    assert_split('"Here he comes!" she said.')
    assert_split('"Here he comes!", she said.')
    assert_split('"Here he comes." ', 'But this is another sentence.')
    assert_split('"Here he comes!". ', "That's what he said.")
    assert_split('The sentence ends here. ', '(Another sentence.)')
    assert_split('The sentence (...) ends here.')
    assert_split('The sentence [...] ends here.')
    assert_split('The sentence ends here (...). ', 'Another sentence.')
    # previously known failed but not now :)
    assert_split("He won't. ", 'Really.')
    assert_split('He will not. ', 'Really.')
    assert_split("He won't go. ", 'Really.')
    assert_split("He won't say no.", 'Not really.')
    assert_split("He won't say No.", 'Not really.')
    assert_split("He won't say no. 5 is better. ", 'Not really.')
    assert_split("He won't say No. 5 is better. ", 'Not really.')
    assert_split('They met at 5 p.m. on Thursday.')
    assert_split('They met at 5 p.m. ', 'It was Thursday.')
    assert_split('This is it: a test.')
    assert_split('12) Make sure that the lamp is on. ', '12) Make sure that the lamp is on. ')
    assert_split('He also offers a conversion table (see Cohen, 1988, p. 123). ')
    # Missing space after sentence end:
    assert_split('James is from the Ireland!', 'He lives in Spain now.')
    # From the abbreviation list:
    assert_split('Jones Bros. have built a successful company.')
    # parentheses:
    assert_split('It (really!) works.')
    assert_split('It [really!] works.')
    assert_split('It works (really!). ', 'No doubt.')
    assert_split('It works [really!]. ', 'No doubt.')
    assert_split('It really(!) works well.')
    assert_split('It really[!] works well.')
    assert_split("A test.\u00A0\n", 'Another test.')
    # try to deal with at least some nbsp that appear in strange places (e.g. Google Docs, web editors)
    assert_split("A test.\u00A0Another test."); # not clear whether this is the best behavior...

    assert_split('The new Yahoo! product is nice.')
    assert_split('Yahoo!, what is it?')
    assert_split('Yahoo!', 'What is it?')

    assert_split("This is a sentence.\u0002 ", 'And this is another one.'); # footnotes in LibOO/OOo look like this

    assert_split('Other good editions are in vol. 4.')
    assert_split('Other good editions are in vol. IX.')
    assert_split('Other good editions are in vol. I think.'); # ambiguous
    assert_split('Who Shall I Say is Calling & Other Stories S. Deziemianowicz, ed. (2009)')
    assert_split('Who Shall I Say is Calling & Other Stories S. Deziemianowicz, ed. ', 'And this is another one.')
    assert_split('This is a sentence written by Ed. ', 'And this is another one.')
  end

  def test_japanese
    @lang_code = 'ja'

    assert_split('これはテスト用の文です。')
    assert_split('これはテスト用の文です。', '追加のテスト用の文です。')
    assert_split('これは、テスト用の文です。')
    assert_split('テスト用の文です！', '追加のテスト用の文です。')
    assert_split('テスト用の文です... ', '追加のテスト用の文です。')
    assert_split('アドレスはhttp://www.test.deです。')

    assert_split('これは(!)の文です。')
    assert_split('これは(!!)の文です。')
    assert_split('これは(?)の文です。')
    assert_split('これは(??)の文です。')
  end

  def test_malayam
    @lang_code = 'ml'

    assert_split(
      <<~TXT.chomp,
        1983 ൽ റിച്ചാർഡ് സ്റ്റാൾമാൻ സ്ഥാപിച്ച ഗ്നു എന്ന സംഘടനയിൽ നിന്നും വളർന്നു വന്ന സോഫ്റ്റ്‌വെയറും ടൂളുകളുമാണ് ഇന്ന് ഗ്നൂ/ലിനക്സിൽ ലഭ്യമായിട്ടുള്ള സോഫ്റ്റ്‌വെയറിൽ സിംഹഭാഗവും.#{' '}
      TXT
      <<~TXT.chomp
        ഗ്നു സംഘത്തിന്റെ മുഖ്യലക്ഷ്യം സ്വതന്ത്ര സോഫ്റ്റ്‌വെയറുകൾ മാത്രം ഉപയോഗിച്ചുകൊണ്ട് യുണിക്സ് പോലുള്ള ഒരു ഓപ്പറേറ്റിംഗ് സിസ്റ്റം നിർമ്മിക്കുന്നതായിരുന്നു.
      TXT
    )
  end

  def test_serbian
    @lang_code = 'sr'

    assert_split('Ово је једна реченица. ')
    assert_split('Ово је једна реченица. ', 'И још једна.')
    assert_split('Једна реченица! ', 'Још једна.')
    # test_split("Ein Satz... ", "Noch einer.");
    assert_split('На адреси http:#www.gov.rs станује српска влада.')
    assert_split('Писмо је стигло 3.10. пре подне.')
    assert_split('Писмо је стигло 31.1. пре подне.')
    assert_split('Писмо је стигло 3.10.2000 поподне.')
    assert_split('Србија је под Турцима била од 14. до 19. века.')

    # Testing (non-)segmentation after Roman numerals
    assert_split('Петар I, познат и као Петар Ослободилац.')
    assert_split('Петар II, познат и као Петар Изгнаник.')
    assert_split('Петар III, принц наследник.')
    assert_split('Александар V Обреновић.')

    # Testing (non-)segmentation in dates and times
    assert_split('Данас је 13.12.2004.')
    assert_split('Данас је 13. децембар.')
    assert_split('Видећемо се 29. фебруара.')
    assert_split('Јесен стиже 23.09. поподне.')
    assert_split('Жена стиже тачно у 17:00 кући.')

    assert_split('Ренесанса је почела у 13. веку и бла бла трућ.')
    assert_split('Све је почело у 13. или 14. веку и бла бла трућ.')
    assert_split('Трајало је све од 13. до 14. века и бла бла трућ.')

    assert_split('Ово је једна(!) реченица.')
    assert_split('Чуо сам једну(!!) реченицу.')
    assert_split('Ово је једна(?) реченица.')
    assert_split('Чујем ли само једну(???) реченицу.')

    assert_split("„Ћуко је креп'о“, рече он")
  end

  private

  def assert_split(*sentences)
    text = sentences.join
    assert_equal(
      sentences,
      engine.segment(text, language: @lang_code)
    )
  end

  def engine
    @engine ||= Srx::Engine.new(Srx::Data.languagetool)
  end
end
