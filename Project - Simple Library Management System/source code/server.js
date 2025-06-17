const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const auth = require('./middleware/auth');
const checkRole = require('./middleware/checkRole');
const Book = require('./models/Book');
const User = require('./models/user');

const app = express();
app.use(bodyParser.json());

mongoose.connect('mongodb://localhost:27017/library');

// Register
app.post('/register', async (req, res) => {
  const { username, password, role } = req.body;
  const hashedPassword = await bcrypt.hash(password, 10);
  const user = new User({ username, password: hashedPassword, role: role || 'user' });
  await user.save();
  res.send({ message: 'User registered' });
});

// Login
app.post('/login', async (req, res) => {
  const { username, password } = req.body;
  const user = await User.findOne({ username });
  if (!user || !(await bcrypt.compare(password, user.password))) {
    return res.status(401).send({ message: 'Invalid credentials' });
  }

  const token = jwt.sign({ username, role: user.role }, 'secret', { expiresIn: '1h' });

  res.send({
    message: 'Login successful',
    username: user.username,
    role: user.role,
    token
  });
});

// Admin view all users (except other admins)
app.get('/admin/users', auth, checkRole('admin'), async (req, res) => {
  const users = await User.find({ role: { $ne: 'admin' } }, '-password');
  res.send(users);
});

// Add Book
app.post('/books', auth, checkRole('admin', 'staff'), async (req, res) => {
  const { bookId, title, author, copies } = req.body;
  const newBook = new Book({ bookId, title, author, copies });
  await newBook.save();
  res.send(newBook);
});

// Delete Book
app.delete('/books/:bookId', auth, checkRole('admin'), async (req, res) => {
  await Book.findOneAndDelete({ bookId: req.params.bookId });
  res.send({ message: 'Deleted' });
});

// Update book by bookId
app.put('/books/:bookId', auth, checkRole('admin', 'staff'), async (req, res) => {
  const updated = await Book.findOneAndUpdate(
    { bookId: req.params.bookId },
    req.body,
    { new: true }
  );
  if (!updated) return res.status(404).send({ message: 'Book not found' });
  res.send(updated);
});

// Get availability
app.get('/books/:bookId/availability', async (req, res) => {
  const book = await Book.findOne({ bookId: req.params.bookId });
  if (!book) return res.status(404).send({ available: false });
  res.send({ available: book.copies > 0 });
});

// Borrow Book (all roles)
app.post('/books/:bookId/borrow', auth, checkRole('user', 'staff', 'admin'), async (req, res) => {
  const user = req.user.username;
  const book = await Book.findOne({ bookId: req.params.bookId });

  if (!book) return res.status(404).send({ message: 'Book not found' });
  if (book.copies <= 0) return res.status(400).send({ message: 'No copies available' });

  const dueDate = new Date();
  dueDate.setDate(dueDate.getDate() + 14);

  book.copies -= 1;
  book.borrowHistory.push({ user, action: 'borrow', dueDate });
  await book.save();

  res.send({ message: 'Book borrowed', dueDate });
});

// Return Book (all roles)
app.post('/books/:bookId/return', auth, checkRole('user', 'staff', 'admin'), async (req, res) => {
  const user = req.user.username;
  const book = await Book.findOne({ bookId: req.params.bookId });

  if (!book) return res.status(404).send({ message: 'Book not found' });

  book.copies += 1;
  book.borrowHistory.push({ user, action: 'return' });
  await book.save();

  res.send({ message: 'Book returned', book });
});

// Book history
app.get('/books/:bookId/history', auth, async (req, res) => {
  const book = await Book.findOne({ bookId: req.params.bookId });
  if (!book) return res.status(404).send({ message: 'Book not found' });

  res.send(book.borrowHistory);
});

// Book borrow status (staff/admin only)
app.get('/books/:bookId/status', auth, checkRole('staff', 'admin'), async (req, res) => {
  const book = await Book.findOne({ bookId: req.params.bookId });
  if (!book) return res.status(404).send({ message: 'Book not found' });

  const history = book.borrowHistory.map(entry => ({
    user: entry.user,
    action: entry.action,
    dueDate: entry.dueDate,
    date: entry.date
  }));

  res.send({ bookId: book.bookId, title: book.title, history });
});

// Overdue books
app.get('/books/overdue', auth, async (req, res) => {
  const now = new Date();
  const books = await Book.find({ 'borrowHistory.dueDate': { $lt: now } });

  const overdueBooks = books.map(book => ({
    bookId: book.bookId,
    title: book.title,
    overdueEntries: book.borrowHistory.filter(entry => entry.dueDate && entry.dueDate < now && entry.action === 'borrow')
  }));

  res.send(overdueBooks);
});

// All books
app.get('/books', async (req, res) => {
  const books = await Book.find();
  res.send(books);
});

// Count books
app.get('/books/count', async (req, res) => {
  const count = await Book.countDocuments();
  res.send({ total: count });
});

// Search books
app.get('/books/search', async (req, res) => {
  const query = req.query.q;
  const books = await Book.find({
    $or: [
      { title: new RegExp(query, 'i') },
      { author: new RegExp(query, 'i') }
    ]
  });
  res.send(books);
});

// Available books
app.get('/books/available', async (req, res) => {
  const books = await Book.find({ copies: { $gt: 0 } });
  res.send(books);
});

// Unavailable books
app.get('/books/unavailable', async (req, res) => {
  const books = await Book.find({ copies: { $lte: 0 } });
  res.send(books);
});

app.listen(3000, () => console.log('Server running on port 3000'));
