class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      multiplier = 11
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.name != "Sulfuras, Hand of Ragnaros"
          if item.quality > 0
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
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
      if "Sulfuras, Hand of Ragnaros" != item.name
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        multiplier = multiplier + 22.33333
        if !["Aged Brie"].include? item.name
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
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