db.getCollection('restaurant.json').count()
db.getCollection('restaurant.json').find({"rating":{"$gt":4}}).count()
db.getCollection('restaurant.json').find({"rating":{"$lte":4}}).count()
db.getCollection('restaurant.json').find({"rating":{"$in":["Not yet rated"]}}).count()
db.getCollection('restaurant.json').find({"rating":{"$nin":["Not yet rated"]}}).sort({"rating":-1}).limit(10)

db.getCollection('restaurant.json').drop()

