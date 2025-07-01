//Imports
const express = require('express');
const cors = require('cors');
const mysql = require("mysql2/promise");
require("dotenv").config();

//Server is put into a variable
const server = express();

//Server configuration for correct operation as an API
server.use(cors());
server.use(express.json({ limit: "50mb" })); //acepta este formato y este peso

//Server started on port 4000
const port = 4000;
server.listen(port, () => {
  console.log(`Super-servidor iniciado <http://localhost:${port}>`);
});

//Connection function
async function getConnection() {
  const connData = {
    host: process.env.MYSQL_HOST,
    port: process.env.MYSQL_PORT,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
  };
  const conn = await mysql.createConnection(connData);
  await conn.connect();
  return conn;
}

//ENDPOINTS API

//End: Error 404
server.use(/.*/, (req, res) => {
  res.status(404).send("ERROR 404: Esta ruta se la inventó usted.");
});
