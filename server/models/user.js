const mongoose = require('mongoose');
const Schema = mongoose.Schema
const productSchema = require('./product')

const userSchema = Schema({
    name:{
        required:true,
        type:String,
        trim:true

    },
    email:{
        type :String,
        required:true,
        trim:true,
        validate:{
            validator:(value)=>{
                const re = /^(?!.{51})[a-z0-9-_.+]+@[a-z0-9]+[a-z0-9-.]*\.[a-z0-9]{2,9}/;
                return value.match(re)
            },
            message:"please enter a valid email address"
        },

    },
    password:{
        type:String,
        required:true,
        trim:true,
        validate:{
            validator:(value)=>{
               return value.length >8;
            },
            message:"the length of password must be greater than 8 characters"
        },
    },
    address:{
        type:String,
        default:""
    },
    type:{
        type:String,
        default:'user'
    },

});

const User = mongoose.model('User',userSchema);
module.exports = User;

