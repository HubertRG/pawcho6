const express = require("express");
const os = require("os");

const app = express();

app.get("/", (req, res) => {
  let text = "<h1>Laboratorium 5</h1>";
  text +=
    "<h3>Nazwa serwera(hostname): " +
    os.hostname +
    "</h3><br>" +
    "<h3>Wersja aplikacji: " +
    process.env.APP_VERSION +
    "</h3><br>" +
    "<h3>Adres IP serwera: " +
    os.networkInterfaces().eth0[0].address +
    "</h3><br>";

  res.send(text);
});

app.listen(3000, () => {
  console.log("Listening on port 3000");
});
