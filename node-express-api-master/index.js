var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

const express = require('express')
const mysql = require('mysql');
const app = express()

/*var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "mabdd"
});

con.connect(function(err) {
    if (err) throw err;
    console.log("Connecté à la base de données MySQL!");
   con.query("ALTER TABLE user ADD id INT NOT NULL AUTO_INCREMENT, add PRIMARY KEY (id)", function (err, result) {
        if (err) throw err;
        console.log("Table UPDATE !");
      });
  });*/

/*con.connect(function(err) {
    if (err) throw err;
    console.log("Connecté à la base de données MySQL!");
   con.query("INSERT INTO artiste(name, description, scene, heure) VALUES ('test3', 'testDescription', 'scene2', '10h30')", function (err, result) {
        if (err) throw err;
        console.log("Table UPDATE !");
      });
  });*/


app.use(express.json())


///// Artist /////
// Get All Artists
app.get('/allArtist', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

    con.connect(function(err) {
        if (err) throw err;        
        con.query("SELECT * FROM artiste", function (err, result) {
            if (err) throw err;
            res.status(200).json(result);
        });
    });
})

// Get Artist By Name
app.get('/allArtist/name', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

    con.connect(function(err) {
        if (err) throw err;
        const name = req.headers.name
        con.query("SELECT * FROM artiste WHERE name = ?",[name], function (err, result) {
            if (err) throw err;
            res.status(200).json(result);
        });
    });
})

// Get Artists By Scene
app.get('/allArtist/scene', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

    con.connect(function(err) {
        if (err) throw err;
        const scene = req.headers.scene
        con.query("SELECT * FROM artiste WHERE scene = ?",[scene], function (err, result) {
            if (err) throw err;
            res.status(200).json(result);
        });
    });
})

// Get Artist By Hour
app.get('/allArtist/hour', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

    con.connect(function(err) {
        if (err) throw err;
        const hour = req.headers.hour
        con.query("SELECT * FROM artiste WHERE heure = ?",[hour], function (err, result) {
            if (err) throw err;
            res.status(200).json(result);
        });
    });
})


///// Scene /////
// Get All Scene
app.get('/allScene', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

    con.connect(function(err) {
        if (err) throw err;
        con.query("SELECT DISTINCT scene FROM artiste", function (err, result) {
            if (err) throw err;
            res.status(200).json(result);
        });
    });
})

///// Create Artist ////
app.post('/createArtist', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

    con.connect(function(err) {
        if (err) throw err;
        const name = req.headers.name
        const description = req.headers.description
        const scene = req.headers.scene
        const hour = req.headers.hour
        var sql = "INSERT INTO artiste(name, description, scene, heure) VALUES (?)"
        var value = [name, description, scene, hour]
        con.query(sql, [value], function (err, result) {
            if (err) throw err;
            res.status(200).json("Update");
        });
    });
})

///// Delete /////
// Delete Artist
app.delete('/deleteArtist', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

      con.connect(function(err) {
        if (err) throw err;
        const name = req.headers.name
        const description = req.headers.description
        const scene = req.headers.scene
        const hour = req.headers.hour
 
        var sql = "DELETE FROM artiste WHERE name = '" + name + "' AND description = '" + description + "' AND scene = '" + scene + "' AND heure = '" + hour + "'"
        con.query(sql, function (err, result) {
            if (err) throw err;
            res.status(200).json("Update");
        });
    });
})

///// USER /////
///// Create USER ////
app.post('/createUser', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

    con.connect(function(err) {
        if (err) throw err;
        const pseudo = req.headers.pseudo
        const name = req.headers.name
        const firstName = req.headers.first
        const email = req.headers.email
        const password = req.headers.password
        const admin = req.headers.admin
        var sql = "INSERT INTO user(pseudo, name, firstName, email, password, admin) VALUES (?)"
        var value = [pseudo, name, firstName, email, password, admin]
        con.query(sql, [value], function (err, result) {
            if (err) throw err;
            res.status(200).json("User Create");
        });
    });
})

///// Update USER ////
app.post('/updateUser', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

    con.connect(function(err) {
        if (err) throw err;
        const id = req.headers.id
        const pseudo = req.headers.pseudo
        const name = req.headers.name
        const firstName = req.headers.first
        const email = req.headers.email
        const admin = req.headers.admin
        var sql = "UPDATE user SET pseudo = '" + pseudo + "', name = '" + name + "', firstName = '" + firstName + "', email = '" + email + "', admin = '" + admin + "' WHERE id = " + id
        con.query(sql, function (err, result) {
            if (err) throw err;
            res.status(200).json("Update");
        });
    });
})

///// Delete USER ////
app.delete('/deleteUser', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

    con.connect(function(err) {
        if (err) throw err;
        const id = req.headers.id
        var sql = "DELETE FROM user WHERE id = '" + id + "'"
        con.query(sql, function (err, result) {
            if (err) throw err;
            res.status(200).json("Update");
        });
    });
})

///// Get USER ////
app.post('/getUser', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

    con.connect(function(err) {
        if (err) throw err;
        const pseudo = req.headers.pseudo
        const password = req.headers.password
        var sql = "SELECT * FROM user WHERE pseudo = '" + pseudo + "' AND password = '" + password + "'"
        con.query(sql, function (err, result) {
            if (err) throw err;
            res.status(200).json(result);
        });
    });
})

// Get All User
app.get('/allUser', (req,res) =>{
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "mabdd"
      });

    con.connect(function(err) {
        if (err) throw err;
        con.query("SELECT * FROM user", function (err, result) {
            if (err) throw err;
            res.status(200).json(result);
        });
    });
})


app.listen(8080, () => {
    console.log("Serveur à l'écoute")
})