// db.fans.insert({
//    "name" : "mark",
//    "fans" : ["steven","crisis","stanly"]
// })

// add item to list
// db.fans.update({"name":"mark"},{"$push":{"fans":"jack"}})
// add multi item to list
// db.fans.update({"name":"mark"},{"$push":{"fans":{"$each":["jack","max"]}}})
// skip tail 3 (if $slice:3 skip head 3)
// db.fans.update({"name":"mark"},{
//     "$push":{
//         "fans":
//         {"$each":["jack","max"],"$slice":-3}
//         }
//     })

// remove all max
// db.fans.update({"name":"mark"},{"$pull" : {"fans":"max"}})
       