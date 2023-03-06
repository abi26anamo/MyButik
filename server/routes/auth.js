const express = require('express');
const User = require('../models/user');
const bycryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken');
const authRouter = express.Router();
const auth = require('../middlewares/auth')


authRouter.post('/api/signup',async (req,res)=>{
    try{
     const {name,email,password }= req.body
     const existingUser = await User.findOne({email})
     if(existingUser){
         return res.status(400).json({msg:"User with same email already exists"});
     }
     const hashpassword = await bycryptjs.hash(password,8)
   let user =  User({
         name,
         email,
         password:hashpassword
     });
      user = await user.save();
      res.json({user})
    }
    catch(err){
        res.status(500).json({err:err.message})
    }

});

authRouter.post('/api/signin',async(req,res)=>{
    try {
        const {email,password} = req.body

        const user = await User.findOne({email})
        if(!user){
          return res.status(400).json({msg:"User with this email doesn't exist"})
        } 
    const isMatch = await bycryptjs.compare(password,user.password);
        if (!isMatch){
            return res.status(400).json({msg:"Incorrect password"});
        }

      const token = jwt.sign({id:user._id},'passwordsecretkey');
      res.json({token,...user._doc});
    } catch (err) {
        res.status(500).json({err:err.message})
    }
    

});

authRouter.post('/tokenIsValid',async(req,res)=>{
  try {
      const token = req.header('x-auth-token');
      if(!token) return res.json(false);

      const isVerified = jwt.verify(token,'passwordsecretkey');
      if(!isVerified) return res.json(false);

      const user = await User.findById(isVerified.id);
      if(!user) return res.json(false);
      res.json(true);

  } catch (err) {
        res.status(500).json({err:err.message});
  }
});

authRouter.post('/',auth,async(req,res)=>{
    const user = User.findById(req.user);
    res.json({...user._doc,token:user.token})

});
module.exports = authRouter;