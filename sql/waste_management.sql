CREATE DATABASE waste_management;
USE waste_management;

CREATE TABLE locations (
location_id INT PRIMARY KEY,
location_name VARCHAR(50)
);

CREATE TABLE waste_types (
waste_type_id INT PRIMARY KEY,
waste_type VARCHAR(50)
);

CREATE TABLE waste_collection (
collection_id INT PRIMARY KEY,
location_id INT,
waste_type_id INT,
quantity INT,
date DATE,
FOREIGN KEY (location_id) REFERENCES locations(location_id),
FOREIGN KEY (waste_type_id) REFERENCES waste_types(waste_type_id)
);

CREATE TABLE recycling (
recycle_id INT PRIMARY KEY,
collection_id INT,
recycled_quantity INT,
FOREIGN KEY (collection_id) REFERENCES waste_collection(collection_id)
);

INSERT INTO locations VALUES
(1, 'Hostel A'),
(2, 'Hostel B'),
(3, 'Canteen');

INSERT INTO waste_types VALUES
(1, 'Wet Waste'),
(2, 'Dry Waste'),
(3, 'Plastic');

INSERT INTO waste_collection VALUES
(1, 1, 1, 10, '2026-04-01'),
(2, 2, 2, 5, '2026-04-01'),
(3, 3, 3, 8, '2026-04-02'),
(4, 1, 2, 6, '2026-04-02');

INSERT INTO recycling VALUES
(1, 1, 6),
(2, 2, 3),
(3, 3, 5),
(4, 4, 4);

-- Queries
SELECT SUM(quantity) AS total_waste FROM waste_collection;

SELECT l.location_name, SUM(wc.quantity)
FROM waste_collection wc
JOIN locations l ON wc.location_id = l.location_id
GROUP BY l.location_name;

SELECT wt.waste_type, SUM(wc.quantity)
FROM waste_collection wc
JOIN waste_types wt ON wc.waste_type_id = wt.waste_type_id
GROUP BY wt.waste_type;

SELECT (SUM(r.recycled_quantity) / SUM(wc.quantity)) * 100
FROM waste_collection wc
JOIN recycling r ON wc.collection_id = r.collection_id;
