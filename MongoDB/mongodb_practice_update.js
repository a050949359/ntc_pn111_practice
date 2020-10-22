// db.user.insert({"name":"mark","age":23});
// db.user.insert({"name":"steven","age":23});
// db.user.insert({"name":"jj","age":23});
// db.user.insert({"name":"mark","age":23});

// db.user.update({"name":"mark"},{"name":"mark","age":18})
// db.user.update({"name":"mark"},{"age":18})
// db.user.update({"age":18},{"name":"mark","age":18})

// 
// db.user.update({"name":"mark"},{"$set":{"age":15}})   
// db.user.update({"name":"mark"},{"$set":{"age":15}},{multi:true})

db.user.update({"name":"steve"},{"$set":{"age":15}},{upsert:true}) 
db.user.update({"name":"steveq"},{"$set":{"age":15}},{upsert:false}) 
