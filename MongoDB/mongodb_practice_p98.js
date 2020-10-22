db.getCollection('video_movieDetails.bson').find({"actors":{ $all:["Mark Hamill"]}},{"title":1,"_id":0})
db.getCollection('pokedex.json').find({"name.japanese":"マタドガス"})   //import json add --jsonArray
db.getCollection('samples_pokemon.bson').find({"weight":{"$in":["90.5 kg"]}})
db.getCollection('pokedex.json').find({"name.english":"Charizard"})
db.getCollection('tweets.bson').find({},{"user.followers_count":1,"_id":0}).sort({"user.followers_count":-1}).limit(3)
// db.getCollection('students.json').update({"_id":51},{"$set":{"scores.0.score":90}})
db.getCollection('students.json').find({"_id":51})