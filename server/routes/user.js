const express = require('express');
const auth = require('../middlewares/auth');
const admin = require('./admin');
const userRouter = express.Router()
const Product = require('../models/product');
const User = require('../models/user');
const Order = require('../models/order');
const authRouter = require('./auth');

userRouter.post('api/add-to-cart',auth,async(req,res)=>{

    try {
        const {id}=req.body;
        const product = await Product.findbyId(id);
        let user = await User.findbyId(req.user);

        if (user.cart.length ==0){
            user.cart.push({product,quantity:1})
        }else{
            let isProductFound = false
            for (let i =0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(id)){
                     isProductFound = true
                }
            }
            if(isProductFound){
                let cartproduct = user.cart.find((cartprod)=>cartprod.cartprod_id.equals(product_id));
                cartproduct.quantity+=1;
            }else{

            }
           
        }
        user = await user.save();
        res.json(user);
    } catch (err) {
        res.status(500).json({err:err.message})
        
    }

});


userRouter.delete('/api/remove-from-cart:id',auth,async (req,res)=>{
    try {
        const {id} = req.params;
        const product = Product.findbyId(id);
        let user = User.findbyId(req.user);
     
            for ( let i =0;i<user.cart.length;i++){
                if (user.cart[i].product_id.equals(id)){
                   if(user.cart.quantity ==1){
                    user.cart.splice(i,1);

                   }else{
                       user.cart[i].quantity-=1
                   }
                }
            }

        
        user = await user.save();
        res.json(user);

    } catch (err) {
        res.status(500).json({err:err.message})   
    }
});
userRouter.post('/api/save-user-address',auth,async(req,res)=>{

    try {
        const {address} = req.body;
        var user = User.findById(req.user);
        user.address = address;
        user = await user.save();
        res.json(user)
    } catch (e) {
        res.status(500).json({e:e.message});
        
    }
 

});

userRouter.post('/api/order',auth,async(req,res)=>{
    try {
        const {cart,totalPrice,address} = req.body;
        let products =[];
        for(let i=0;i<cart.length;i++){
            let product = await Product.findbyId(cart[i].product_id)
            if (product.quantity>=cart[i].quantity){
               product.quantity-=cart[i].quantity
               products.push({product,quantity:cart[i].quantity})
               await product.save();
            }else{
                return res.status(400).json({msg:`${product} is out of stock!`})
            }
        }
        let user = User.findById(req.user);
        user.cart=[];
        user = await user.save();
        let order = new Order({
            products,
            totalPrice,
            address,
            orderedAt: new Date().getTime,
            userId: req.user,
            Status,
        });
        order = await order.save()
        res.json(order)
    } catch (e) {
        res.status(500).json({e:e.message});
    }
})

authRouter.get('/api/order/me',auth,async (req,res)=>{
    try {
    const orders = await Order.find({userId:req.user});
    res.json(orders);

    } catch (err) {
        res.status(500).json({err:err.message})
    }
});

module.exports= userRouter;
