//Server and connection
const express = requiere('express');
const cors = requiere('cors');

//Server configuration for correct operation as an API
server.use(cors());
server.use(express.json({ limit: "50mb" })); //acepta este formato y este peso

//Server started on port 4000
const port = 4000;
server.listen(port, () => {
  console.log(`Super-servidor iniciado <http://localhost:${port}>`);
});
