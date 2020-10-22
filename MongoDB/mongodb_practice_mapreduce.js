// db.orders.insert([{ "class" : "1", "price" : 10,"count" : 180},
// { "class" : "1" ,"price" : 10,"count" : 350},
// { "class" : "2" ,"price" : 10,"count" : 90},
// { "class" : "2" ,"price" : 10,"count" : 320},
// { "class" : "2" ,"price" : 10,"count" : 150}])
// db.orders.mapReduce(
//     function(){
//         var total = this.price * this.count
//         //this.class is key, total are values
//         emit(this.class,total)    
//     },
//     
//     function(key,values){
//         var total = 0;
//         for(var i=0; i<values.length; i++) {
//             total += values[i];   
//         }
//         return total;
//     },
//     
//     { out : "mapReduceTest" }
// )

// db.orders2.insert([{ "class" : "1", "price" : 10,"count" : 180},
// { "class" : "1" ,"price" : 10,"count" : 350},
// { "class" : "2" ,"price" : 10,"count" : 90},
// { "class" : "2" ,"price" : 10,"count" : 320},
// { "class" : "2" ,"price" : 10,"count" : 150},
// { "class" : "3" ,"price" : 10,"count" : 100},
// { "class" : "3" ,"price" : 10,"count" : 200},
// { "class" : "3" ,"price" : 10,"count" : 300}])

db.orders2.mapReduce(
    function(){
        var total = this.price * this.count
        //this.class is key, total are values
        emit(this.class,total)    
    },
    
    function(key,values){
        var total = 0;
        for(var i=0; i<values.length; i++) {
            total += values[i];   
        }
        return total;
    },
    
    { 
        out :"test",
        query :{ class: {"$in":["2","3"]}},
        finalize :
            function(key, reducedVal){
                reducedVal = reducedVal + "dollar";
                return reducedVal;
            }
        
    }
)