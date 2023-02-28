CREATE TABLE patients(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(100),
	date_of_birth DATE
);

CREATE TABLE medical_histories(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	admitted_at TIMESTAMP,
	patient_id INT,
	status VARCHAR(50),
	CONSTRAINT fk_patients FOREIGN KEY(patient_id) REFERENCES patients(id)
);

CREATE TABLE invoices(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	total_amount DECIMAL(8,2),
	generated_at TIMESTAMP,
	payed_at TIMESTAMP,
	medical_history_id INT,
	CONSTRAINT fk_medical_histories FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE treatments(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	type VARCHAR(150),
	name VARCHAR(100)
);

CREATE TABLE invoice_items(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	unit_price DECIMAL(5,2),
	quantity INT,
	total_price DECIMAL(10,2),
	invoice_id INT,
	treatment_id INT,
	CONSTRAINT fk_invoices FOREIGN KEY(invoice_id) REFERENCES invoices(id),
	CONSTRAINT fk_treatments FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);

-- Many-to-many relations
CREATE TABLE medical_histories_treatments(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	medical_histories_id INT,
	treatments_id INT,
	CONSTRAINT fk_medical_histories FOREIGN KEY(medical_histories_id) REFERENCES medical_histories(id),
	CONSTRAINT fk_treatments FOREIGN KEY(treatments_id) REFERENCES treatments(id)
);

-- Indexing Foreign Keys
CREATE INDEX patient_id_asc ON medical_histories(patient_id ASC);
CREATE INDEX medical_history_id_asc ON invoices(medical_history_id ASC);
CREATE INDEX invoice_id_asc ON invoice_items(invoice_id ASC);
CREATE INDEX treatment_id_asc ON invoice_items(treatment_id ASC);
CREATE INDEX medical_histories_id_asc ON medical_histories_treatments(medical_histories_id ASC);
CREATE INDEX treatments_id_asc ON medical_histories_treatments(treatments_id ASC);