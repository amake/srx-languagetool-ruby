# frozen_string_literal: true

require 'test_helper'

class LanguageToolRulesTest < Minitest::Test
  def test_english
    @lang_code = 'en'

    test_split("Here's a")
    test_split("Here's a sentence. ", "And here's one that's not comp")
    test_split('Or did you install it (i.e. MS Word) yourself?')

    test_split('This is a sentence. ')
    test_split('This is a sentence. ', 'And this is another one.')
    test_split('This is a sentence.', "Isn't it?", 'Yes, it is.')
    test_split('This is e.g. Mr. Smith, who talks slowly...',
               'But this is another sentence.')
    test_split('Chanel no. 5 is blah.')
    test_split('Mrs. Jones gave Peter $4.5, to buy Chanel No 5.',
               'He never came back.')
    test_split("On p. 6 there's nothing. ", 'Another sentence.')
    test_split('Leave me alone!, he yelled. ', 'Another sentence.')
    test_split('"Leave me alone!", he yelled.')
    test_split("'Leave me alone!', he yelled. ", 'Another sentence.')
    test_split("'Leave me alone!,' he yelled. ", 'Another sentence.')
    test_split('This works on the phrase level, i.e. not on the word level.')
    test_split("Let's meet at 5 p.m. in the main street.")
    test_split('James comes from the U.K. where he worked as a programmer.')
    test_split("Don't split strings like U.S.A. please.")
    test_split('Hello ( Hi! ) my name is Chris.')
    test_split("Don't split strings like U. S. A. either.")
    test_split("Don't split strings like U.S.A either.")
    test_split("Don't split... ", 'Well you know. ', 'Here comes more text.')
    test_split("Don't split... well you know. ", 'Here comes more text.')
    test_split('The "." should not be a delimiter in quotes.')
    test_split('"Here he comes!" she said.')
    test_split('"Here he comes!", she said.')
    test_split('"Here he comes." ', 'But this is another sentence.')
    test_split('"Here he comes!". ', "That's what he said.")
    test_split('The sentence ends here. ', '(Another sentence.)')
    test_split('The sentence (...) ends here.')
    test_split('The sentence [...] ends here.')
    test_split('The sentence ends here (...). ', 'Another sentence.')
    # previously known failed but not now :)
    test_split("He won't. ", 'Really.')
    test_split('He will not. ', 'Really.')
    test_split("He won't go. ", 'Really.')
    test_split("He won't say no.", 'Not really.')
    test_split("He won't say No.", 'Not really.')
    test_split("He won't say no. 5 is better. ", 'Not really.')
    test_split("He won't say No. 5 is better. ", 'Not really.')
    test_split('They met at 5 p.m. on Thursday.')
    test_split('They met at 5 p.m. ', 'It was Thursday.')
    test_split('This is it: a test.')
    test_split('12) Make sure that the lamp is on. ', '12) Make sure that the lamp is on. ')
    test_split('He also offers a conversion table (see Cohen, 1988, p. 123). ')
    # Missing space after sentence end:
    test_split('James is from the Ireland!', 'He lives in Spain now.')
    # From the abbreviation list:
    test_split('Jones Bros. have built a successful company.')
    # parentheses:
    test_split('It (really!) works.')
    test_split('It [really!] works.')
    test_split('It works (really!). ', 'No doubt.')
    test_split('It works [really!]. ', 'No doubt.')
    test_split('It really(!) works well.')
    test_split('It really[!] works well.')
    test_split("A test.\u00A0\n", 'Another test.')
    # try to deal with at least some nbsp that appear in strange places (e.g. Google Docs, web editors)
    test_split("A test.\u00A0Another test."); # not clear whether this is the best behavior...

    test_split('The new Yahoo! product is nice.')
    test_split('Yahoo!, what is it?')
    test_split('Yahoo!', 'What is it?')

    test_split("This is a sentence.\u0002 ", 'And this is another one.'); # footnotes in LibOO/OOo look like this

    test_split('Other good editions are in vol. 4.')
    test_split('Other good editions are in vol. IX.')
    test_split('Other good editions are in vol. I think.'); # ambiguous
    test_split('Who Shall I Say is Calling & Other Stories S. Deziemianowicz, ed. (2009)')
    test_split('Who Shall I Say is Calling & Other Stories S. Deziemianowicz, ed. ', 'And this is another one.')
    test_split('This is a sentence written by Ed. ', 'And this is another one.')
  end

  def test_japanese
    @lang_code = 'ja'

    test_split('これはテスト用の文です。')
    test_split('これはテスト用の文です。', '追加のテスト用の文です。')
    test_split('これは、テスト用の文です。')
    test_split('テスト用の文です！', '追加のテスト用の文です。')
    test_split('テスト用の文です... ', '追加のテスト用の文です。')
    test_split('アドレスはhttp://www.test.deです。')

    test_split('これは(!)の文です。')
    test_split('これは(!!)の文です。')
    test_split('これは(?)の文です。')
    test_split('これは(??)の文です。')
  end

  def test_malayam
    @lang_code = 'ml'

    test_split(
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

    test_split('Ово је једна реченица. ')
    test_split('Ово је једна реченица. ', 'И још једна.')
    test_split('Једна реченица! ', 'Још једна.')
    # test_split("Ein Satz... ", "Noch einer.");
    test_split('На адреси http:#www.gov.rs станује српска влада.')
    test_split('Писмо је стигло 3.10. пре подне.')
    test_split('Писмо је стигло 31.1. пре подне.')
    test_split('Писмо је стигло 3.10.2000 поподне.')
    test_split('Србија је под Турцима била од 14. до 19. века.')

    # Testing (non-)segmentation after Roman numerals
    test_split('Петар I, познат и као Петар Ослободилац.')
    test_split('Петар II, познат и као Петар Изгнаник.')
    test_split('Петар III, принц наследник.')
    test_split('Александар V Обреновић.')

    # Testing (non-)segmentation in dates and times
    test_split('Данас је 13.12.2004.')
    test_split('Данас је 13. децембар.')
    test_split('Видећемо се 29. фебруара.')
    test_split('Јесен стиже 23.09. поподне.')
    test_split('Жена стиже тачно у 17:00 кући.')

    test_split('Ренесанса је почела у 13. веку и бла бла трућ.')
    test_split('Све је почело у 13. или 14. веку и бла бла трућ.')
    test_split('Трајало је све од 13. до 14. века и бла бла трућ.')

    test_split('Ово је једна(!) реченица.')
    test_split('Чуо сам једну(!!) реченицу.')
    test_split('Ово је једна(?) реченица.')
    test_split('Чујем ли само једну(???) реченицу.')

    test_split("„Ћуко је креп'о“, рече он")
  end

  private

  def test_split(*sentences)
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
