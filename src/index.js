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
//POST - New sentence (marca_tiempo = null) -
 server.post('/api/frases', async (req, res) => {
    const conn = await getConnection();
    const [resultado] = await conn.execute(`
        INSERT INTO frases (texto, descripcion, fk_id_personajes)
            VALUES (?, ?, ?);`,
            [req.body.texto, req.body.descripcion, req.body.fk_id_personajes]
    );
    await conn.end();
    res.json(resultado);
 });

//GET - List of phrases (with character info and title) -
server.get('/api/frases', async (req, res) => {
    const conn = await getConnection();
    const [resultado] = await conn.query(`
        SELECT texto, fk_id_personajes, b.nombre, b.apellidos, b.ocupacion, c.titulo
            FROM frases a
                JOIN personajes b
                    ON (a.fk_id_personajes = b.id_personajes) 
                LEFT JOIN capitulos c 
                    ON (a.id = c.frases_id);`
    );
    await conn.end();
    res.json(resultado);
});

//GET - Get a specific phrase
server.get('/api/frases/:id', async (req, res) => {
    const conn = await getConnection();
    const [resultado] = await conn.query(`
        SELECT texto
            FROM frases 
                WHERE id = ?;`,
                [req.params.id]
    );
    await conn.end();
    res.json(resultado);
});

//PUT - Update existing phrase -
server.put('/api/frases/:id', async (req, res) => {
    const conn = await getConnection();
    const [resultado] = await conn.execute(`
    UPDATE frases
        SET texto = ?
            WHERE id = ?;`,
        [req.body.texto, req.params.id]
    );
    await conn.end();
    res.json(resultado);
});

//DELETE - Delete a sentence -
server.delete('/api/frases/:id', async (req, res) => {
    const conn = await getConnection();
    const [resultado] = await conn.execute(`
    DELETE FROM frases
        WHERE id=?;`,
        [req.params.id]
    );
    await conn.end();
    res.json(resultado);
    });

//End: Error 404
server.use(/.*/, (req, res) => {
  res.status(404).send("ERROR 404: Esta ruta se la inventó usted.");
});
