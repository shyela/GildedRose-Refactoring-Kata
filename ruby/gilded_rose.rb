class GildedRose

  def initialize(items)
    @items = items
  end

  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"

  LEGENDARY_ITEM_SULFURAS = "Sulfuras, Hand of Ragnaros"

  AGED_BRIE = "Aged Brie"

  FIRST_DEMAND_INCREASE = 10

  SECOND_DEMAND_INCREASE = 5

  def update_quality()
    @items.each do |item|

      if is_legendary_item(item)
        next
      end

      decrement_sell_in(item)

      if is_backstage_pass(item)
        increment_quality(item)
        if item.sell_in < FIRST_DEMAND_INCREASE
          increment_quality(item)
        end
        if item.sell_in < SECOND_DEMAND_INCREASE
          increment_quality(item)
        end

        if has_sell_in_expired(item)
          item.quality = 0
        end

        next
      end

      if gets_worse_with_time(item)
        decrement_quality(item)
      else
        increment_quality(item)
      end

      if has_sell_in_expired(item)
        if is_aged_brie(item)
          increment_quality(item)
        else
          decrement_quality(item)
        end
      end

    end
  end

  private

  def is_aged_brie(item)
    item.name == AGED_BRIE
  end

  def is_backstage_pass(item)
    item.name == BACKSTAGE_PASSES
  end

  def is_legendary_item(item)
    item.name == LEGENDARY_ITEM_SULFURAS
  end

  def decrement_sell_in(item)
    item.sell_in = item.sell_in - 1
  end

  def gets_worse_with_time(item)
    !is_aged_brie(item) and !is_backstage_pass(item)
  end

  def increment_quality(item)
    if item.quality < 50
      item.quality = item.quality + 1
    end
  end

  def has_sell_in_expired(item)
    item.sell_in < 0
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