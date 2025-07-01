//Server and connection
const express = require('express');
const cors = require('cors');

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

//ENDPOINTS API

//End: Error 404
server.use(/.*/, (req, res) => {
  res.status(404).send("ERROR 404: Esta ruta se la inventó usted.");
});
