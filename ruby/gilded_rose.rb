class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each(&method(:update_quality_for_item))
  end

  MAX_QUALITY = 50

  def update_quality_for_item(item)
    if is_legendary_item?(item)
      return
    end

    if is_aged_item?(item)
      handle_aged_item(item)
      return
    end

    if is_backstage_pass?(item)
      handle_backstage_pass(item)
      return
    end

    handle_generic_item(item)
  end

  def handle_aged_item(item)
    increment_quality(item)
    decrement_sell_in(item)
    if item.sell_in < 0
      increment_quality(item)
    end
  end

  def handle_backstage_pass(item)
    increase_backstage_pass_quality(item)
    decrement_sell_in(item)
    if item.sell_in < 0
      expire_item(item)
    end
  end

  def handle_generic_item(item)
    decrement_quality(item)
    decrement_sell_in(item)

    if item.sell_in < 0
      decrement_quality(item)
    end
  end

  def is_aged_item?(item)
    item.name == "Aged Brie"
  end

  def is_legendary_item?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def is_backstage_pass?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def increase_backstage_pass_quality(item)
    increment_quality(item)
    if item.sell_in < 11
      increment_quality(item)
    end
    if item.sell_in < 6
      increment_quality(item)
    end
  end

  def can_decrease_quality(item)
    item.quality > 0
  end

  def can_increase_quality(item)
    item.quality < MAX_QUALITY
  end

  def increment_quality(item)
    if can_increase_quality(item)
      item.quality = item.quality + 1
    end
  end

  def decrement_quality(item)
    if can_decrease_quality(item)
      item.quality = item.quality - 1
    end
  end

  def decrement_sell_in(item)
    item.sell_in = item.sell_in - 1
  end

  def expire_item(item)
    item.quality = 0
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