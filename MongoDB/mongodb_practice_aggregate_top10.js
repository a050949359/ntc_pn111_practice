// db.restaurant.json.aggregate([{"$match":{"rating":{"$nin":["Not yet rated"]}}},{"$sort":{"rating":-1}}, {"$limit":10} ])
db.restaurant.json.aggregate([{"$group":{"_id":"$type_of_food", "rate":{"$avg" : "$rating"}}}, {"$sort":{"rate":-1}},{"$limit":10}])


