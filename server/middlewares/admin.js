const jwt = require('jsonwebtoken');
const User = require('../models/user');
const admin = async (req,res,next)=> {
    try {
         const token = req.header('x-auth-token');
         if(!token){
             res.status(401).json({msg:"No auth token,access denied"})
             return;
             
         }
         const isVerified = jwt.verify(token,'passwordsecretkey');
         if(!isVerified) {
             return res.status(401).json({msg:'token verification failed,authorization denied'});
            }
         const user = await User.findById(isVerified.id);
         if(user.type == 'user'|| user.type=='seller'){
             return res.status(401).json({msg:'You are not an admin!'})
         }
         req.user = isVerified;
         req.token = token;
         next();
    } catch (err) {
       return res.status(500).json({err:err.message});
       
    }

}
module.exports = admin;