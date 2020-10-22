//  db.agg.insert({"id" : 1 ,"name" : "mark","age" : 20,
//   "assets" : 100000000 })
//  db.agg.insert({"id" : 2, "name" : "steven", "age" : 40,
// "assets" : 1000000 })

db.agg.aggregate([
    {"$project" : { "id":1, _id:0 }}
    ,{"$match":{age:{$gt:10, $lte:30}}}
])
    
db.agg.aggregate([
    {"$project": { _id:0 }}
    ,{"$match": {age: {$gt: 10, $lte: 30}}}
])