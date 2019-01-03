require_relative '../lib/data_mining'
require "test/unit"
require 'minitest/autorun'

class DataMiningTest < Minitest::Test
  def setup
    @data_mining = DataMining::DataMining.new
  end

  def test_returns_true_if_block_is_not_empty
    @data_mining.parse('https://ain.ua')
    assert_equal true, @data_mining.to_db('.item-title').any?
  end

  def test_returns_raise_if_url_is_not_url
    assert_raises(DataMining::Parser::Exceptions::UrlFailure) do
      @data_mining.parse('something')
    end
  end

  def test_returns_raise_if_site_is_not_found
    assert_raises(DataMining::Parser::Exceptions::UrlFailure) do
      @data_mining.parse('https://something.com')
    end
  end

  def test_returns_raise_if_css_class_is_empty
    @data_mining.parse('https://ain.ua')
    assert_raises(DataMining::Parser::Exceptions::InvalidElementsCount) do
      @data_mining.to_db('')
    end
  end

  def test_returns_raise_if_css_class_is_nil
    @data_mining.parse('https://ain.ua')
    assert_raises(DataMining::Parser::Exceptions::InvalidElementsCount) do
      @data_mining.to_db(nil)
    end
  end

  def test_returns_false_if_css_does_not_have_that_class
    @data_mining.parse('https://ain.ua')
    assert_equal false, @data_mining.to_db('.m-title').any?
  end
end
