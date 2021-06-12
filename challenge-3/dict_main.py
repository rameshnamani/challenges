from functools import reduce
import operator

def prepare(data, map):
    return reduce(operator.getitem, map, data)

data = {
   "Spades":{
      "Aces":1,
      "Jacks":2,
      "Queens":3,
      "Kings":4
   },
   "Diamonds":{
      "Aces":5,
      "Jacks":6,
      "Queens":7,
      "Kings":8
   },
   "Hearts":{
      "Aces":9,
      "Jacks":10,
      "Queens":11,
      "Kings":12
   },
   "Clubs":{
      "Aces":13,
      "Jacks":14,
      "Queens":15,
      "Kings":16
   }
}