const db = require('../db');

// Add Doctor (Admin only)
exports.addDoctor = async (req, res) => {
  const { name, specialization, schedule } = req.body;

  try {
    await db.execute(
      'INSERT INTO doctors (name, specialization, schedule) VALUES (?, ?, ?)',
      [name, specialization, JSON.stringify(schedule)]
    );
    res.status(201).json({ message: 'Doctor added successfully' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// List Doctors
exports.getDoctors = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM doctors');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Update Doctor
exports.updateDoctor = async (req, res) => {
  const { name, specialization, schedule } = req.body;

  try {
    await db.execute(
      'UPDATE doctors SET name = ?, specialization = ?, schedule = ? WHERE id = ?',
      [name, specialization, JSON.stringify(schedule), req.params.id]
    );
    res.json({ message: 'Doctor updated successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Delete Doctor
exports.deleteDoctor = async (req, res) => {
  try {
    await db.execute('DELETE FROM doctors WHERE id = ?', [req.params.id]);
    res.json({ message: 'Doctor deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
