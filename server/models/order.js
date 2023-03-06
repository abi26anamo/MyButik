const productSchema = require('./product')
const mongoose = require('mongoose');

const orderSchema = mongoose.Schema({
    products:[
        {
          product:productSchema,
          quantity:{
              type:Number,
              required:true
          }
        }
    ],
    totalPrice:{
        type:Number,
        required:true
    },
    address:{
        type:String,
        required:true
    },
    userId:{
        type:String,
        required:true
    },
    orderedAt:{
        type:Number,
        required:true
    },
    Status:{
        type:Number,
        default:0
    }
    

});

const Order = mongoose.model('Order',orderSchema)
module.exports = Order;
