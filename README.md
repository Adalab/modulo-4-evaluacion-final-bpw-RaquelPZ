# Pasos para crear un servidor Express

1. Crear una carpeta donde irá el proyecto.

2. Abrir la carpeta

3. Lanzar el comando `npm init` y contestar a sus preguntas.
   - En entrypoint vamos a poner `src/index.js`

4. Creamos la carpeta `/src/` y dentro el fichero `/src/index.js`.

5. Editamos el `/package.json` y dentro de scripts añadimos estos dos:
   - `"start": "node src/index.js"`
   - `"dev": "node --watch src/index.js"`
   - Acordáos de las comas al final de cada prop.
   - No hace falta quitar el `"test"` de `"scripts"`.

6. Instalamos las dependencias:

   1. Instalamos, sí o sí, la biblioteca **Express**  como dependencia:
      - `npm i express`

   2. Si vamos a hacer endpoints que formen parte de un API RESTful, instalamos como dependencia **CORS**:
      - `npm i cors`

   3. Si necesitamos usar las tablas de una base de datos, instalamos como dependencia **MySQL2** y **dotEnv**:
      - `npm i mysql2 dotenv`

   4. Si queremos hacer endpoints para registro y login de usuarias, instalamos como dependencia **bCrypt** y **JsonWebToken**:
      - `npm i bcrypt jsonwebtoken`

   5. Si necesitamos usar un motor de plantillas (para hacer enpoints con ficheros dinámicos), instalamos como dependencia **EJS**:
      - `npm i ejs`

      > NOTA: Lo normal  será instalar:
      > `npm i express cors mysql2 dotenv`

7. Escribimos en el fichero `/src/index.js` el código de un servidor mínimo:

   ```js
   const express = require('express');

   // Creamos una vari con el servidor
   const server = express();

   // SECCIÓN DE CONFIGURACIÓN DE SERVER

   // Arrancamos el servidor en el puerto 4000
   const port = 4000;
   server.listen( port, () => {
     console.log(`Servidor iniciado <http://localhost:${port}>`);  
   });


8. Arrancamos el servidor con `npm run dev` y abrimos una página en el navegador con la dirección `http://localhost:4000/` (¡no se abre ni se actualiza automáticamente como en React!)


## Para configurar Express como servidor de APIS

1. Importamos las bibliotecas **cors**, **mysql2** y **dotenv** al principio del fichero.

   ```js
   const cors = require('cors');
   const mysql = require("mysql2/promise");
   require("dotenv").config();
   ```

2. Añadioms la configuración para que el servidor Express pueda recibir peticiones de cualquier dirección e interprete el json que llega en el body de la petición (en la sección de configuración del server Express):

   ```js
   // Configuramos server para que funcione bien como API
   server.use( cors() );
   server.use( express.json({limit: '25Mb'}) );
   ```

3. Creamos un fichero `/.env` en la carpeta raíz de nuestro proyecto con las 5 variables que definen la configuración de la conexión con la base de datos MySQL. Ponemos los valores de nuestra base de datos (de localhost o de Aiven) entre las comillas:

   ```yaml
   MYSQL_HOST=''
   MYSQL_PORT='3306'
   MYSQL_USER=''
   MYSQL_PASSWORD=''
   MYSQL_DATABASE=''
   ```

4. Creamos una función para crear una conexión y conectarnos a la base de datos:

   ```js
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
   ```

5. Añadimos un endpoint (`server.method('/ruta', (req,res) =>{})`) por cada acción que queramos realizar por cada ruta que representa un concepto de nuestra App o una tabla de nuestra base de datos.
