
// models/User.js
const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  username: { type: String, unique: true },
  password: String,
  role: { type: String, enum: ['admin', 'staff', 'user'], default: 'user' }
});

module.exports = mongoose.model('User', userSchema);

