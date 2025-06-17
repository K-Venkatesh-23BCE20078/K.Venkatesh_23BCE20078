
const mongoose = require('mongoose');

const bookSchema = new mongoose.Schema({
  bookId: { type: String, unique: true },
  title: String,
  author: String,
  copies: Number,
  borrowHistory: [
    {
      user: String,
      action: String,
      date: { type: Date, default: Date.now },
      dueDate: Date 
    }
  ]
});

module.exports = mongoose.model('Book', bookSchema);
