const bcrypt = require('bcryptjs');
const db = require('../db');

// Register Patient
exports.register = async (req, res) => {
  const { name, email, password, age, contact } = req.body;

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    await db.execute(
      'INSERT INTO patients (name, email, password, age, contact) VALUES (?, ?, ?, ?, ?)',
      [name, email, hashedPassword, age, contact]
    );
    res.status(201).json({ message: 'Patient registered successfully' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Login Patient
exports.login = async (req, res) => {
  const { email, password } = req.body;

  try {
    const [rows] = await db.execute('SELECT * FROM patients WHERE email = ?', [email]);
    const patient = rows[0];

    if (!patient || !(await bcrypt.compare(password, patient.password))) {
      return res.status(401).json({ message: 'Invalid email or password' });
    }

    req.session.userId = patient.id;
    req.session.role = 'patient';
    res.json({ message: 'Login successful' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// View Profile
exports.viewProfile = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM patients WHERE id = ?', [req.session.userId]);
    res.json(rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Update Profile
exports.updateProfile = async (req, res) => {
  const { name, age, contact } = req.body;

  try {
    await db.execute(
      'UPDATE patients SET name = ?, age = ?, contact = ? WHERE id = ?',
      [name, age, contact, req.session.userId]
    );
    res.json({ message: 'Profile updated successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Delete Account
exports.deleteAccount = async (req, res) => {
  try {
    await db.execute('DELETE FROM patients WHERE id = ?', [req.session.userId]);
    req.session.destroy();
    res.json({ message: 'Account deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
