# -*- coding: utf-8 -*-

import unittest

from gilded_rose import Item, GildedRose


class GildedRoseAcceptanceTests(unittest.TestCase):

    GOLDEN_MASTER_FILENAME = "gilded_rose_golden_master.txt"

    def setUp(self):
        self.golden_master = None
        try:
            with open(self.GOLDEN_MASTER_FILENAME) as file:
                self.golden_master = file.read()
        except:
            pass

        self.items = [
            Item(name="+5 Dexterity Vest", sell_in=10, quality=20),
            Item(name="Aged Brie", sell_in=2, quality=0),
            Item(name="Elixir of the Mongoose", sell_in=5, quality=7),
            Item(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80),
            Item(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80),
            Item(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),
            Item(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49),
            Item(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49),
            Item(name="Conjured Mana Cake", sell_in=3, quality=6),  # <-- :O
        ]

    def test_thirty_one_days_acceptance(self):

        output = ""
        for day in range(31):
            daystring = "-------- day {} --------\n".format(day)
            daystring += "name, sellIn, quality\n"
            for item in self.items:
                daystring += "{}\n".format(repr(item))
            daystring += "\n"
            output += daystring

            GildedRose(self.items).update_quality()

        if self.golden_master is not None:
            self.assertEquals(self.golden_master, output)
        else:
            print('Updating golden master file')
            with open(self.GOLDEN_MASTER_FILENAME, 'w') as file:
                file.write(output)


if __name__ == '__main__':
    unittest.main()
