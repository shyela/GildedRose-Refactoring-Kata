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
    if item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert"
      if can_decrease_quality(item)
        decrementQuality(item)
      end
    else
      if can_increase_quality(item)
        incrementQuality(item)
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          if can_increase_quality(item)
            if item.sell_in < 11
              incrementQuality(item)
            end
            if item.sell_in < 6
              incrementQuality(item)
            end
          end
        end
      end
    end
    if "Sulfuras, Hand of Ragnaros" != item.name
      item.sell_in = item.sell_in - 1
    end
    if item.sell_in < 0
      if !["Aged Brie"].include? item.name
        if item.name != "Backstage passes to a TAFKAL80ETC concert"
          if can_decrease_quality(item)
            decrementQuality(item)
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        if can_increase_quality(item)
          incrementQuality(item)
        else
          nil
        end
      end
    end
  end

  def can_decrease_quality(item)
    item.quality > 0 && item.name != "Sulfuras, Hand of Ragnaros"
  end

  def can_increase_quality(item)
    item.quality < MAX_QUALITY
  end

  def incrementQuality(item)
    item.quality = item.quality + 1
  end

  def decrementQuality(item)
    item.quality = item.quality - 1
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