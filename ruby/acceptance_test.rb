require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

GOLDEN_MASTER_FILENAME = 'gilded_rose_golden_master.txt'.freeze

class TestGildedRoseAcceptance < Test::Unit::TestCase
  
  def setup
    super

    @golden_master = nil
    begin
      @golden_master = IO.readlines(GOLDEN_MASTER_FILENAME)
    rescue Exception => e
    end

    @items = [
      Item.new('+5 Dexterity Vest', 10, 20),
      Item.new('Aged Brie', 2, 0),
      Item.new('Elixir of the Mongoose', 5, 7),
      Item.new('Sulfuras, Hand of Ragnaros', 0, 80),
      Item.new('Sulfuras, Hand of Ragnaros', -1, 80),
      Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20),
      Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 49),
      Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 49),
      Item.new('Conjured Mana Cake', 3, 6),  # <-- :O
    ]

  end

  def test_thirty_one_days_acceptance

    gilded_rose = GildedRose.new @items

    output = []
    (0..30).each do |day|
      output.push("-------- day #{day} --------\n")
      output.push("name, sellIn, quality\n")

      @items.each do |item|
        output.push("#{item}\n")
      end

      output.push("\n")

      gilded_rose.update_quality

    end

    if @golden_master
      @golden_master.each_with_index do |item, idx|
        assert_equal item, output[idx]
      end
    else
      puts 'Updating golden master file...'
      IO.write(GOLDEN_MASTER_FILENAME, output.join)
    end
  end

end