const jwt = require('jsonwebtoken');

const auth = (req,res,next)=>{
    try {
        const token = req.header('x-auth-token');
        if (!token){
            return res.status(401).json({msg:"No auth token,access denied"});
        }
        const isVerified = jwt.verify(token,'passwordsecretkey');
        if(!isVerified) return res.status(401).json({msg:'token verification failed,authorization denied'});

        req.user = isVerified.id;
        req.token = token;
        next();
    } catch (err) {
        res.status(500).json({err:err.message})
        
    }

}

module.exports = auth;