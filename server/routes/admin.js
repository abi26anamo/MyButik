const express = require('express')
const admin = require('../middlewares/admin')
const adminRouter = express.Router()
const {Product} = require('../models/product')
const {Order}= require('../models/order')


adminRouter.post("/admin/add-product",admin,async (req,res)=>{
  try { 
      const {name,description,images,price,quantity,category}=req.body;
      product =new Product({
          name,
          description,
          images,
          price,
          quantity,
          category, 
      });
      let product = await product.save()
      res.json(product)
  } catch (err) {
      return res.status(500).json({err:err.toString()})  
  }
})

adminRouter.get('/admin/get-products',admin,async (req,res)=>{
    try {
        const product = await Product.find({});
        res.json(product)
    } catch (err) {
       return res.status(500).json({err:err.message})
        
    }
})


adminRouter.post('/admin/delete-product',admin,async(req,res)=>{
    try{
        const {id}=req.body;
        const product = await  Product.findByIdandDelete(id);
        res.json(product)
    }catch(err){
       return res.status(500).json({err:err.toString()})
    }
})
adminRouter.get('/admin/get-orders',admin,async (req,res)=>{
    try {
        const orders = await Order.find({})
        res.json(orders)
    } catch (err) {
        return res.status(500).json({err:err.message})
    }
})
module.exports = admin;