db.getCollection('video_movieDetails.bson').find({"runtime":{"$gt":120}})
db.getCollection('video_movieDetails.bson').find({"runtime":{"$gt":120}}).count()
db.getCollection('video_movieDetails.bson').find({"runtime":{"$nin":[null]}}).sort({"runtime":1}).limit(5)

db.getCollection('video_movieDetails.bson').drop()