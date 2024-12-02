const express = require('express');
const mysql = require('mysql2');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');

dotenv.config();

const app = express();
app.use(express.json());

const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

db.connect(err => {
    if (err) throw err;
    console.log('Connected to the database');
});

app.listen(3000, () => console.log('Server running on port 3000'));


// User registration for patients
app.post('/register', async (req, res) => {
    const { first_name, last_name, email, password, phone, date_of_birth, gender, address } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    db.query(
        'INSERT INTO Patients (first_name, last_name, email, password_hash, phone, date_of_birth, gender, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [first_name, last_name, email, hashedPassword, phone, date_of_birth, gender, address],
        (err, results) => {
            if (err) return res.status(500).json({ error: err.message });
            res.status(201).json({ message: 'User registered successfully' });
        }
    );
});

// Login
app.post('/login', (req, res) => {
    const { email, password } = req.body;

    db.query('SELECT * FROM Patients WHERE email = ?', [email], async (err, results) => {
        if (err || results.length === 0) return res.status(400).json({ error: 'Invalid email or password' });

        const user = results[0];
        const match = await bcrypt.compare(password, user.password_hash);

        if (!match) return res.status(400).json({ error: 'Invalid email or password' });

        const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET);
        res.json({ message: 'Logged in successfully', token });
    });
});

//Appointment booking
app.post('/appointments', (req, res) => {
    const { patient_id, doctor_id, appointment_date, appointment_time } = req.body;
    
    db.query(
        'INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status) VALUES (?, ?, ?, ?, ?)',
        [patient_id, doctor_id, appointment_date, appointment_time, 'scheduled'],
        (err, results) => {
            if (err) return res.status(500).json({ error: err.message });
            res.status(201).json({ message: 'Appointment booked successfully' });
        }
    );
});

