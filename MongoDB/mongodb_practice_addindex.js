// db.getCollection('test1').ensureIndex({"x":1})

db.test1.find({
        "x":{"$gt":5000}
    }).sort({"x":-1}).explain("executionStats")
db.test2.find({
        "x":{"$gt":5000}
    }).sort({"x":-1}).explain("executionStats")