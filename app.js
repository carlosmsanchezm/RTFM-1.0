const express = require('express');
const app = express();

app.get('/', (req, res) => res.send('Work Hard BytchAssBass'));
app.listen(3000, () => console.log('Server ready'));
