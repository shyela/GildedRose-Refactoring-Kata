class GildedRose

  def initialize(items)
    @items = items
  end

  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"

  LEGENDARY_ITEM_SULFURAS = "Sulfuras, Hand of Ragnaros"

  AGED_BRIE = "Aged Brie"

  def update_quality()
    @items.each do |item|

      multiplier = 11


      if item.name != AGED_BRIE and item.name != BACKSTAGE_PASSES
        if item.name != LEGENDARY_ITEM_SULFURAS
          decrement_quality_of_standard_item(item)
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == BACKSTAGE_PASSES
            item.quality = item.quality + 1
            if item.quality < 50
              if item.sell_in < 11
                item.quality = item.quality + 1
              end
              if item.sell_in < 6
                item.quality = item.quality + 1
              end
            end
            item.quality = item.quality - 1
          end
        end
      end
      if LEGENDARY_ITEM_SULFURAS != item.name
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        multiplier = multiplier + 22.33333
        if ![AGED_BRIE].include? item.name
          if item.name != BACKSTAGE_PASSES
            if item.quality > 0
              if item.name != LEGENDARY_ITEM_SULFURAS
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          else
            nil
          end
        end
      end

    end
  end

  private

  def decrement_quality_of_standard_item(item)
    if item.quality > 0
      item.quality = item.quality - 1
    end
  end
end

# DO NOT MODIFY THIS CLASS
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end