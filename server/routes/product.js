const express = require('express');
const productRouter = express.Router()
const Product = require('../models/product')
const auth = require('../middlewares/auth');
const ratingSchema = require('../models/ratings');

productRouter.get('/api/products',auth,async(req,res)=>{
   try {
    const product = await Product.find({
        name:{$regex:req.params.name,$options:"i"}
    });
    res.json(product);
   } catch (err) {
       res.status(500).json({err:err.message})
   }
})

productRouter.get('/api/products/search/:name',auth,async(req,res)=>{
    try {
        const product = await Product.find({searchQuery:req.query.name});
        res.json(product)
    } catch (err) {
        res.status(500).json({err:err.message})
    }
});


productRouter.get('/api/rate-product',auth,async(req,res)=>{
    try {
        const {id,rating}= req.body
        let product = await Product.findbyId(id);
        for(let i =0;i<product.ratings.length;i++){
            if(product.ratings[i].userId == req.user){
                product.rating.splice(i,1);
                break;
            }
        }
      const   ratingSchema ={
          userId:req.user,
          rating,
      }
  product.ratings.push(ratingSchema); 
  product = await product.save()
  res.json(product)

    } catch (err) {
        res.status(500).json({err:err.message});
    }
})

productRouter.get('/api/deal-of-day',auth,async(req,res)=>{
    try {
    let products =  await Product.find({})

    products.sort((a,b)=>{
       let aSum =0
       let bSum =0
       for (let i =0;i<a.ratings.length;i++){
           aSum+=a.ratings[i].rating
       }

       for(let i =0;i<b.ratings.length;i++){
           bSum+=b.ratings[i].rating
       }
     return aSum <bSum ?1:-1
    })
        res.json(products[0]);
    } catch (err) {
        res.status(500).json({err:err.message})
        
    }
})
module.exports = productRouter;