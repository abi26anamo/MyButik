const express = require('express');
const authRouter = require('./routes/auth')
const adminRouter = require('./routes/admin')
const mongoose = require('mongoose');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

const Mongo_Url = "mongodb://127.0.0.1:27017/amazon"

const app = express()
app.use(express.json())
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
const port = 3000
    mongoose
    .connect(Mongo_Url,{
        useNewUrlParser: true,
        useUnifiedTopology: true 
      })
    .then(()=>{
        console.log("connection success")
    })
    .catch((err)=>{
        console.log(err);
    });

app.listen(port,console.log(`server is running at ${port}...`))



