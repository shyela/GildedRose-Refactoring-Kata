class GildedRose

  def initialize(items)
    @items = items
  end

  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"

  LEGENDARY_ITEM_SULFURAS = "Sulfuras, Hand of Ragnaros"

  AGED_BRIE = "Aged Brie"

  def update_quality()
    @items.each do |item|

      if is_legendary_item(item)

      end

      if item.name != AGED_BRIE and item.name != BACKSTAGE_PASSES
        if !is_legendary_item(item)
          decrement_quality_of_standard_item(item)
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == BACKSTAGE_PASSES
            if item.quality < 50
              if item.sell_in < 11
                item.quality = item.quality + 1
              end
              if item.sell_in < 6
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if LEGENDARY_ITEM_SULFURAS != item.name
        item.sell_in = item.sell_in - 1
      end
      if has_sell_in_expired(item)
        if ![AGED_BRIE].include? item.name
          if item.name != BACKSTAGE_PASSES
            if item.quality > 0
              if !is_legendary_item(item)
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end

    end
  end

  private

  def has_sell_in_expired(item)
    item.sell_in < 0
  end

  def is_legendary_item(item)
    item.name == LEGENDARY_ITEM_SULFURAS
  end

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