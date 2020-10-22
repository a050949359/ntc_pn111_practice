db.getCollection('home').find({})

db.home.insert({"id" : 1 ,"like" : 0})
 
//id == 1, like ++
db.home.update({"id" : 1},{"$inc" : {"like" : 1}})

 