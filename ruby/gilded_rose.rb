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
        next
      end

      item.sell_in = item.sell_in - 1

      if gets_better_with_time(item)
        decrement_quality(item)
      else
        increment_quality(item)
        if is_backstage_pass(item)
          if item.sell_in < 10
            increment_quality(item)
          end
          if item.sell_in < 5
            increment_quality(item)
          end
        end
      end

      if has_sell_in_expired(item)
        if item.name != AGED_BRIE
          if item.name != BACKSTAGE_PASSES
            decrement_quality(item)
          else
            item.quality = 0
          end
        else
          increment_quality(item)
        end
      end
    end
  end

  private

  def is_backstage_pass(item)
    item.name == BACKSTAGE_PASSES
  end

  def gets_better_with_time(item)
    item.name != AGED_BRIE and !is_backstage_pass(item)
  end

  def increment_quality(item)
    if item.quality < 50
      item.quality = item.quality + 1
    end
  end

  def has_sell_in_expired(item)
    item.sell_in < 0
  end

  def is_legendary_item(item)
    item.name == LEGENDARY_ITEM_SULFURAS
  end

  def decrement_quality(item)
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