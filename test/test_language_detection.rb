require File.expand_path('../helper', __FILE__)

class RoccoLanguageDetection < Test::Unit::TestCase
  def test_basic_detection
    r = Rocco.new( 'filename.py' ) { "" }

    assert_equal Rouge::Lexers::Python, r.detect_language(), "`detect_language()` should return the correct language"
    assert_equal Rouge::Lexers::Python, r.options[:language], "`@options[:language]` should be set to the correct language"
  end

  def test_fallback_default
    r = Rocco.new( 'filename.an_extension_with_no_meaning_whatsoever' ) { "" }

    assert_equal Rouge::Lexers::PlainText, r.detect_language(), "`detect_language()` should return `text` when nothing else is detected"
    assert_equal Rouge::Lexers::Ruby, r.options[:language], "`@options[:language]` should be set to `ruby` when nothing else is detected"
  end

  def test_invalid_language
    assert_raise do
      Rocco.new( 'filename.an_extension_with_no_meaning_whatsoever', '', { :language => "not_a_language" } ) { "" }
    end
  end

  def test_fallback_user
    r = Rocco.new( 'filename.an_extension_with_no_meaning_whatsoever', '', { :language => "c" } ) { "" }

    assert_equal Rouge::Lexers::PlainText, r.detect_language(), "`detect_language()` should return `text` nothing else is detected"
    assert_equal Rouge::Lexers::C, r.options[:language], "`@options[:language]` should be set to the user's setting when nothing else is detected"
  end
end
