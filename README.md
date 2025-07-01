# 📡 Servidor Express con MySQL – Guía Paso a Paso

Este proyecto configura un servidor API RESTful con Node.js, Express y una base de datos MySQL. A continuación se detallan los pasos para crear y ejecutar el servidor correctamente.

---

## 🛠️ 1. Inicializar el proyecto

1. Crea una carpeta para tu proyecto:
   ```bash
   mkdir mi-servidor-express
   cd mi-servidor-express
   ```

2. Inicializa el proyecto con NPM:
   ```bash
   npm init
   ```

   - Acepta las opciones por defecto o personaliza según necesites.
   - En el campo `entry point`, escribe: `src/index.js`.

3. Crea el archivo de entrada:
   ```bash
   mkdir src
   touch src/index.js
   ```

---

## ⚙️ 2. Configurar `package.json`

En la sección `"scripts"` de tu `package.json`, añade:

```json
"scripts": {
  "start": "node src/index.js",
  "dev": "node --watch src/index.js"
}
```

> Asegúrate de no eliminar otras propiedades como `"test"` y de usar comas correctamente.

---

## 📦 3. Instalar dependencias

Instala las dependencias necesarias:

```bash
npm install express cors mysql2 dotenv
```

### Dependencias adicionales según necesidades:

- Autenticación:
  ```bash
  npm install bcrypt jsonwebtoken
  ```

- Motor de plantillas (si usas vistas con HTML dinámico):
  ```bash
  npm install ejs
  ```

---

## 🌐 4. Configurar el servidor Express

Edita `src/index.js` con el siguiente contenido mínimo:

```js
const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
require('dotenv').config();

const server = express();

// Configuración
server.use(cors());
server.use(express.json({ limit: '25mb' }));

// Puerto
const port = 4000;
server.listen(port, () => {
  console.log(`✅ Servidor iniciado en http://localhost:${port}`);
});
```

---

## 🔐 5. Configurar las variables de entorno

Crea un archivo `.env` en la raíz del proyecto:

```env
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER='tu_usuario'
MYSQL_PASSWORD='tu_contraseña'
MYSQL_DATABASE='nombre_base_de_datos'
```

> Reemplaza los valores por los reales de tu entorno local o remoto (como Aiven).

---

## 🔌 6. Conexión con MySQL

Agrega esta función en `index.js` o en un archivo separado (`db.js`):

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

---

## 🚀 7. Crear tus endpoints

Agrega un endpoint por cada funcionalidad o tabla. Ejemplo: obtener una frase por ID:

```js
server.get('/api/frases/:id', async (req, res) => {
  const conn = await getConnection();

  try {
    const [resultado] = await conn.query(
      `SELECT texto FROM frases WHERE id = ?;`,
      [req.params.id]
    );

    if (resultado.length === 0) {
      res.status(404).json({ error: 'Frase no encontrada' });
    } else {
      res.json(resultado[0]);
    }
  } catch (error) {
    console.error('Error al obtener la frase:', error);
    res.status(500).json({ error: 'Error interno' });
  } finally {
    await conn.end();
  }
});
```

---

## 🧪 8. Ejecutar el servidor

### En modo desarrollo:
```bash
npm run dev
```

### En modo producción:
```bash
npm start
```

Abre en el navegador:  
[http://localhost:4000](http://localhost:4000)

---

## ✅ Recomendaciones

- Usa Postman o Thunder Client para probar tus endpoints.
- Usa `console.log()` para depurar valores como `req.body` o `req.params`.
- Mantén los errores controlados con `try...catch` para evitar que el servidor se caiga.