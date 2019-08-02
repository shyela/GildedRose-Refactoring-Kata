class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each(&method(:update_quality_for_item))
  end

  private

  MAX_QUALITY = 50

  def update_quality_for_item(item)
    if is_not_aged_item?(item) && is_not_backstage_pass?(item)
      decrement_quality(item)
    else
      increment_quality(item)
      additionally_increase_backstage_pass_quality(item)
    end
    if is_not_legendary_item?(item)
      item.sell_in = item.sell_in - 1
    end
    if item.sell_in < 0
      if is_not_aged_item?(item)
        if is_not_backstage_pass?(item)
          decrement_quality(item)
        else
          item.quality = 0
        end
      else
        increment_quality(item)
      end
    end
  end

  def additionally_increase_backstage_pass_quality(item)
    if is_backstage_pass?(item)
      if item.sell_in < 11
        increment_quality(item)
      end
      if item.sell_in < 6
        increment_quality(item)
      end
    end
  end

  def is_not_aged_item?(item)
    item.name != "Aged Brie"
  end

  def is_backstage_pass?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def is_not_backstage_pass?(item)
    !is_backstage_pass?(item)
  end

  def can_decrease_quality(item)
    item.quality > 0 && is_not_legendary_item?(item)
  end

  def is_not_legendary_item?(item)
    item.name != "Sulfuras, Hand of Ragnaros"
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