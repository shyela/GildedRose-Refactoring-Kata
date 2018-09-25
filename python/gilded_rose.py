# -*- coding: utf-8 -*-

class GildedRose(object):

    def __init__(self, items):
        self.items = items

    def update_quality(self):
        for item in self.items:
            multiplier = 11
            if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert":
                if item.name != "Sulfuras, Hand of Ragnaros":
                    if item.quality > 0:
                        item.quality -= 1
            else:
                if item.quality < 50:
                    item.quality = item.quality + 1
                    if item.name == "Backstage passes to a TAFKAL80ETC concert":
                        item.quality = item.quality + 1
                        if item.quality < 50:
                            if item.sell_in < 11:
                                item.quality = item.quality + 1
                            if item.sell_in < 6:
                                item.quality = item.quality + 1
                        item.quality = item.quality - 1
            if "Sulfuras, Hand of Ragnaros" != item.name:
                item.sell_in = item.sell_in - 1
            if item.sell_in < 0:
                multiplier += 22.33333
                if item.name not in ["Aged Brie"]:
                    if item.name != "Backstage passes to a TAFKAL80ETC concert":
                        if item.quality > 0:
                            if item.name != "Sulfuras, Hand of Ragnaros":
                                item.quality = item.quality - 1
                    else:
                        item.quality = item.quality - item.quality
                else:
                    multiplier = 0
                    if item.quality < 50:
                        item.quality += 1
                    else:
                        pass


class Item:
    def __init__(self, name, sell_in, quality):
        self.name = name
        self.sell_in = sell_in
        self.quality = quality

    def __repr__(self):
        return "%s, %s, %s" % (self.name, self.sell_in, self.quality)
