// db.ox.insert({"id" :1 , "status" : "o" , "count" : 5})
// db.ox.insert({"id" :2 , "status" : "o", "count" : 5}) 
// db.ox.insert({"id" :3 , "status" : "o", "count" : 5})
// db.ox.insert({"id" :4 , "status" : "x", "count" : 10})
// db.ox.insert({"id" :5 , "status" : "x", "count" : 10})
// db.ox.insert({"id" :6 , "status" : "x", "count" : 11})
// db.ox.aggregate([{"$group": {"_id": "$status", "total": {"$sum": "$count"}}}])
// db.ox.aggregate([{"$group": {"_id":{"status":"$status", "count":"$count"}, "amount": { "$sum": 1 }}}])

// db.agg2.insert({"name" : "mark", "fans" : [
//        {"name" : "steven","age":20},
//        {"name" : "max","age":60},
//        {"name" : "stanly","age":30}
// ]})
// db.agg2.aggregate([{"$unwind": "$fans"}])

// db.agg3.insert({"name" : "mark", "age" : 18}) 
// db.agg3.insert({"name" : "steven", "age" : 38})
// db.agg3.insert({"name" : "max", "age" : 10}) 
// db.agg3.insert({"name" : "stanlly", "age" : 28})
// db.agg3.aggregate([{"$sort":{"age":-1}}, {"$limit":3}, {"$skip":2}])

// db.agg4.insert({ "id" : 1,"name" : "mark","age" : 20,"sex" : "M",
//  "fans" : [{"name" : "steven"},{"name" : "max"}],"phone" : "xxxxx"})
// 
// db.agg4.insert({ "id" : 2,"name" : "steven",
// "age" : 40,"sex" : "M","fans" : [{"name" : "mark"},{"name" : "max"}],"phone" : "xxxxx"})
//   db.agg4.insert({ "id" : 3,"name" : "marry","age" : 30,"sex" : "S",
// "fans" : [{"name" : "mark"},{"name" : "max"},{"name" : "jack"}],
// "phone" : "xxxxx"})
//  db.agg4.insert({ "id" : 4,"name" : "jack","age" : 21,"sex" : "M","fans" :
//  [{"name" : "mark"}],"phone" : "xxxxx"
// })
// db.getCollection('agg4').aggregate([{"$sort":{"age":1}}, {"$skip":1}, {"$limit":1}])
 