const express = require('express');
const app = express();
const riot = require('riot');
const listTag = require('./tags/app.tag');
const XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

let html = null
riot.renderAsync(listTag, {id: 'prawn'}).then(function(rendered) {
    html = rendered
    console.log(html);
});



// app.get('/', function (req, res) {
//   res.send('Hello World!')
// });

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
});

app.use(express.static(__dirname))