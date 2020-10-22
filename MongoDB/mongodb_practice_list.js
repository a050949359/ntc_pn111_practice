// db.userfans2.insert([{"id":"1","name":"mark",
//    "fans":["steven","stanly","max"],
//   "x":[10,20,30]},{"id":"2","name":"steven",
//    "fans":["max","stanly"],
//   "x":[5,6,30]},{"id":"3","name":"stanly",
//    "fans":["steven","max"],
//   "x":[15,6,30,40]},{"id":"4","name":"max",
//    "fans":["steven","stanly"],
// "x":[15,26,330,41,1]}])

db.userfans2.find({"fans":{"$all":["steven","max"]}})
db.userfans2.find({"fans":{"$size":3}})
db.userfans2.find({"name":"mark"},{"fans":{"$slice":1}})
db.userfans2.find({"x":{"$elemMatch":{"$gt":30, "$lt":100}}})
 
db.userfans2.find({"name":/^s/})