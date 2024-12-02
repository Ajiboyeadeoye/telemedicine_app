const db = require('../db');

// Book Appointment
exports.bookAppointment = async (req, res) => {
  const { doctorId, date } = req.body;

  try {
    await db.execute(
      'INSERT INTO appointments (patient_id, doctor_id, date) VALUES (?, ?, ?)',
      [req.session.userId, doctorId, date]
    );
    res.status(201).json({ message: 'Appointment booked successfully' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Get Appointments
exports.getAppointments = async (req, res) => {
  try {
    const [rows] = await db.execute(
      'SELECT * FROM appointments WHERE patient_id = ?',
      [req.session.userId]
    );
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Cancel Appointment
exports.cancelAppointment = async (req, res) => {
  try {
    await db.execute('UPDATE appointments SET status = ? WHERE id = ?', ['canceled', req.params.id]);
    res.json({ message: 'Appointment canceled successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
