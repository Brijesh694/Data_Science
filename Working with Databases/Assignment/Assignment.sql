 create database assignment;

use assignment;

-- --------------------------------------------------
-- Tables from Database tables.docx
-- --------------------------------------------------

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(100),
    city VARCHAR(100),
    grade INT,
    salesman_id INT
);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);

CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    commission DECIMAL(5,2)
);

CREATE TABLE emp_details (
    emp_idno INT PRIMARY KEY,
    emp_fname VARCHAR(100),
    emp_lname VARCHAR(100),
    emp_dept INT
);

CREATE TABLE item_mast (
    pro_id INT PRIMARY KEY,
    pro_name VARCHAR(100),
    pro_price DECIMAL(10,2),
    pro_com INT
);

-- Optional NoSQL to SQL table
CREATE TABLE employee_json (
    name VARCHAR(100),
    age INT,
    department VARCHAR(50),
    salary DECIMAL(10,2),
    joining_date DATE
);

-- --------------------------------------------------
-- Tables from HRDB.docx
-- --------------------------------------------------

CREATE TABLE regions (
    region_id INT UNSIGNED NOT NULL,
    region_name VARCHAR(25),
    PRIMARY KEY (region_id)
);

CREATE TABLE countries (
    country_id CHAR(2) NOT NULL,
    country_name VARCHAR(40),
    region_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (country_id),
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE locations (
    location_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    street_address VARCHAR(40),
    postal_code VARCHAR(12),
    city VARCHAR(30) NOT NULL,
    state_province VARCHAR(25),
    country_id CHAR(2) NOT NULL,
    PRIMARY KEY (location_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE departments (
    department_id INT UNSIGNED NOT NULL,
    department_name VARCHAR(30) NOT NULL,
    manager_id INT UNSIGNED,
    location_id INT UNSIGNED,
    PRIMARY KEY (department_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE jobs (
    job_id VARCHAR(10) NOT NULL,
    job_title VARCHAR(35) NOT NULL,
    min_salary DECIMAL(10, 2),
    max_salary DECIMAL(10, 2),
    PRIMARY KEY (job_id)
);

CREATE TABLE employees (
    employee_id INT UNSIGNED NOT NULL,
    first_name VARCHAR(20),
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(25) NOT NULL,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    salary DECIMAL(8, 2) NOT NULL,
    commission_pct DECIMAL(5, 2),
    manager_id INT UNSIGNED,
    department_id INT UNSIGNED,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

CREATE TABLE job_history (
    employee_id INT UNSIGNED NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    department_id INT UNSIGNED NOT NULL,
    UNIQUE KEY (employee_id, start_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- --------------------------------------------------
-- View from HRDB
-- --------------------------------------------------

CREATE VIEW emp_details_view AS
SELECT e.employee_id,
       e.job_id,
       e.manager_id,
       e.department_id,
       d.location_id,
       l.country_id,
       e.first_name,
       e.last_name,
       e.salary,
       e.commission_pct,
       d.department_name,
       j.job_title,
       l.city,
       l.state_province,
       c.country_name,
       r.region_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN regions r ON c.region_id = r.region_id
JOIN jobs j ON e.job_id = j.job_id;

-- insert values

-- Inserts for Database tables.docx tables

INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id)
VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
(3001, 'Brad Guzan', 'London', NULL, 5005);


INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.40, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.60, '2012-04-25', 3002, 500);

INSERT INTO salesman (salesman_id, name, city, commission)
VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);

INSERT INTO emp_details (emp_idno, emp_fname, emp_lname, emp_dept)
VALUES
(127323, 'Michale', 'Robbin', 57),
(526689, 'Carlos', 'Snares', 63),
(843795, 'Enric', 'Dosio', 57),
(328717, 'Jhon', 'Snares', 63),
(444527, 'Joseph', 'Dosni', 47),
(659831, 'Zanifer', 'Emily', 47),
(847674, 'Kuleswar', 'Sitaraman', 57),
(748681, 'Henrey', 'Gabriel', 47),
(555935, 'Alex', 'Manuel', 57),
(539569, 'George', 'Mardy', 27),
(733843, 'Mario', 'Saule', 63),
(631548, 'Alan', 'Snappy', 27),
(839139, 'Maria', 'Foster', 57);

INSERT INTO item_mast (pro_id, pro_name, pro_price, pro_com)
VALUES
(101, 'Motherboard', 3200.00, 15),
(102, 'Keyboard', 450.00, 16),
(103, 'ZIP drive', 250.00, 14),
(104, 'Speaker', 550.00, 16),
(105, 'Monitor', 5000.00, 11),
(106, 'DVD drive', 900.00, 12),
(107, 'CD drive', 800.00, 12),
(108, 'Printer', 2600.00, 13),
(109, 'Refill cartridge', 350.00, 13),
(110, 'Mouse', 250.00, 12);


-- dataset 
INSERT INTO regions (region_id, region_name)
VALUES
(1, 'Europe'),
(2, 'Americas'),
(3, 'Asia'),
(4, 'Middle East and Africa');

INSERT INTO countries (country_id, country_name, region_id)
VALUES
('IT', 'Italy', 1),
('JP', 'Japan', 3),
('US', 'United States of America', 2),
('CA', 'Canada', 2),
('CN', 'China', 3),
('IN', 'India', 3),
('AU', 'Australia', 3),
('ZW', 'Zimbabwe', 4),   
('SG', 'Singapore', 3),
('UK', 'United Kingdom', 1),
('FR', 'France', 1),
('DE', 'Germany', 1),
('ZM', 'Zambia', 4),
('EG', 'Egypt', 4),
('BR', 'Brazil', 2),
('CH','Switzerland',1),
('NL','Netherlands',1),
('MX','Mexico',2),
('KW','Kuwait',4),
('IL','Israel',4),
('DK','Denmark',1),
('HK','HongKong',3),
('NG','Nigeria',4),
('AR','Argentina',2),
('BE','Belgium',1);


INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
VALUES
(1000, '1297 Via Cola di Rie', '989', 'Roma', NULL, 'IT'),
(1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT'),
(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
(1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP'),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
(1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US'),
(1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US'),
(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
(1800, '147 Spadina Ave', 'MSV 2L7', 'Toronto', 'Ontario', 'CA'),
(1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA'),
(2000,'40-5-12 Laogianggen','190518','Beijing',NULL,'CN'),
(2100,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN'),
(2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU'),
(2300,'198 Clementi North','540198','Singapore',NULL,'SG'),
(2400,'8204 Arthur St',NULL,'London',NULL,'UK'),
(2500,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK'),
(2600,'9702 Chester Road','09629850293','Stretford','Manchester','UK'),
(2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE'),
(2800,'Rua Frei Caneca 1360 ','01307-002','Sao Paulo','Sao Paulo','BR'),
(2900,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH'),
(3000,'Murtenstrasse 921','3095','Bern','BE','CH'),
(3100,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL'),
(3200,'Mariano Escobedo 9991','11932','Mexico City','Distrito Federal,','MX');


SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'Purchasing', 114, 1700),
(40, 'Human Resources', 203, 2400),
(50, 'Shipping', 121, 1500),
(60, 'IT', 103, 1400),
(70, 'Public Relations', 204, 2700),
(80, 'Sales', 145, 2500),
(90, 'Executive', 100, 1700),
(100, 'Finance', 108, 1700),
(110, 'Accounting', 205, 1700),
(120,'Treasury',NULL,1700),
(130,'Corporate Tax',NULL,1700),
(140,'Control And Credit',NULL,1700),
(150,'Shareholder Services',NULL,1700),
(160,'Benefits',NULL,1700),
(170,'Manufacturing',NULL,1700),
(180,'Construction',NULL,1700),
(190,'Contracting',NULL,1700),
(200,'Operations',NULL,1700),
(210,'IT Support',NULL,1700),
(220,'NOC',NULL,1700),
(230,'IT Helpdesk',NULL,1700),
(240,'Government Sales',NULL,1700),
(250,'Retail Sales',NULL,1700),
(260,'Recruiting',NULL,1700),
(270,'Payroll',NULL,1700);

SET FOREIGN_KEY_CHECKS = 1;
commit;

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES
('AD_PRES', 'President', 20080.00, 40000.00),
('AD_VP', 'Administration Vice President', 15000.00, 30000.00),
('AD_ASST', 'Administration Assistant', 3000.00, 6000.00),
('FI_MGR', 'Finance Manager', 8200.00, 16000.00),
('FI_ACCOUNT', 'Accountant', 4200.00, 9000.00),
('AC_MGR', 'Accounting Manager', 8200.00, 16000.00),
('AC_ACCOUNT', 'Public Accountant', 4200.00, 9000.00),
('SA_MAN', 'Sales Manager', 10000.00, 20080.00),
('SA_REP', 'Sales Representative', 6000.00, 12008.00),
('PU_MAN', 'Purchasing Manager', 8000.00, 15000.00),
('PU_CLERK', 'Purchasing Clerk', 2500.00, 5500.00),
('ST_MAN', 'Stock Manager', 5500.00, 8500.00),
('ST_CLERK', 'Stock Clerk', 2000.00, 5000.00),
('SH_CLERK', 'Shipping Clerk', 2500.00, 5500.00),
('IT_PROG', 'Programmer', 4000.00, 10000.00),
('MK_MAN', 'Marketing Manager', 9000.00, 15000.00),
('MK_REP', 'Marketing Representative', 4000.00, 9000.00),
('HR_REP', 'Human Resources Representative', 4000.00, 9000.00),
('PR_REP', 'Public Relations Representative', 4500.00, 10500.00);
commit;
-- --------------------------------------------------
-- INSERT into employees table
-- --------------------------------------------------
select job_id from employees;
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date,
                       job_id, salary, commission_pct, manager_id, department_id) VALUES
(100, 'Steven', 'King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000.00, NULL, NULL, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '2005-09-21', 'AD_VP', 17000.00, NULL, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13', 'AD_VP', 17000.00, NULL, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000.00, NULL, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '2007-05-21', 'IT_PROG', 6000.00, NULL, 103, 60),
(105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '2005-06-25', 'IT_PROG', 4800.00, NULL, 103, 60),
(106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '2006-02-05', 'IT_PROG', 4800.00, NULL, 103, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '2007-02-07', 'IT_PROG', 4200.00, NULL, 103, 60),
(108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '2002-08-17', 'FI_MGR', 12000.00, NULL, 101, 100),
(109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '2002-08-16', 'FI_ACCOUNT', 9000.00, NULL, 108, 100),
(110, 'John', 'Chen', 'JCHEN', '515.124.4269', '2005-09-28', 'FI_ACCOUNT', 8200.00, NULL, 108, 100),
(111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '2005-11-30', 'FI_ACCOUNT', 7700.00, NULL, 108, 100),
(112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', '2006-03-07', 'FI_ACCOUNT', 7800.00, NULL, 108, 100),
(113, 'Luis', 'Popp', 'LPOPP', '515.124.4567', '2007-12-07', 'FI_ACCOUNT', 6900.00, NULL, 108, 100),
(114, 'Den', 'Raphaely', 'DRAPHELY', '515.127.4561','1994-12-07', 'PU_MAN', 11000, NULL, 100, 30),
(115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', '1995-05-18', 'PU_CLERK', 3100, NULL, 114, 30),
(116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', '1997-12-24', 'PU_CLERK', 2900, NULL, 114, 30),
(117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564','1997-07-24', 'PU_CLERK', 2800, NULL, 114, 30),
(118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565','1998-11-15', 'PU_CLERK', 2600, NULL, 114, 30),
(119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566','1999-08-10', 'PU_CLERK', 2500, NULL, 114, 30),
(120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234','1996-07-18', 'ST_MAN', 8000, NULL, 100, 50),
(121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', '1997-04-10', 'ST_MAN', 8200, NULL, 100, 50),
(122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234','1995-05-01', 'ST_MAN', 7900, NULL, 100, 50),
(123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234','1997-10-10', 'ST_MAN', 6500, NULL, 100, 50),
(124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234','1999-11-16','ST_MAN', 5800, NULL, 100, 50),
(125, 'Julia', 'Nayer', 'JNAYER', '650.124.1214', '1997-07-16', 'ST_CLERK', 3200, NULL, 120, 50),
(126, 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', '1998-09-28', 'ST_CLERK', 2700, NULL, 120, 50),
(127, 'James', 'Landry', 'JLANDRY', '650.124.1334','1999-01-14',  'ST_CLERK', 2400, NULL, 120, 50),
(128, 'Steven', 'Markle', 'SMARKLE', '650.124.1434','2000-03-08','ST_CLERK', 2200, NULL, 120, 50),
(129, 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', '1997-08-20',  'ST_CLERK', 3300, NULL, 121, 50),
(130, 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', '1997-10-30', 'ST_CLERK', 2800, NULL, 121, 50),
(131, 'James', 'Marlow', 'JAMRLOW', '650.124.7234','1998-02-16', 'ST_CLERK', 2500, NULL, 121, 50),
(132, 'TJ', 'Olson', 'TJOLSON', '650.124.8234','1998-04-10', 'ST_CLERK', 2100, NULL, 121, 50),
(133, 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', '1998-06-14', 'ST_CLERK', 3300, NULL, 122, 50),
(134, 'Michael', 'Rogers', 'MROGERS', '650.127.1834', '1998-08-26', 'ST_CLERK', 2900, NULL, 122, 50),
(135, 'Ki', 'Gee', 'KGEE', '650.127.1734','1999-12-12',  'ST_CLERK', 2400, NULL, 122, 50),
(136, 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', '2000-02-06', 'ST_CLERK', 2200, NULL, 122, 50),
(137, 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', '1994-07-14', 'ST_CLERK', 3600, NULL, 123, 50),
(138, 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', '1995-10-26', 'ST_CLERK', 3200, NULL, 123, 50),
(139, 'John', 'Seo', 'JSEO', '650.121.2014', '1996-02-12', 'ST_CLERK', 2700, NULL, 123, 50),
(140, 'Joshua', 'Patel', 'JPATEL', '650.121.1834', '1996-04-06', 'ST_CLERK', 2500, NULL, 123, 50),
(141, 'Trenna', 'Rajs', 'TRAJS', '650.121.1634', '1997-10-17', 'ST_CLERK', 3500, NULL, 124, 50),
(142, 'Curtis', 'Davies', 'CDAVIES', '650.121.1434', '1998-01-29', 'ST_CLERK', 3100, NULL, 124, 50),
(143, 'Randall', 'Matos', 'RMATOS', '650.121.1214', '1998-03-15', 'ST_CLERK', 2600, NULL, 124, 50),
(144, 'Peter', 'Vargas', 'PVARGAS', '650.121.1114', '1998-07-09', 'ST_CLERK', 2500, NULL, 124, 50),
(145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', '1996-10-01', 'SA_MAN', 14000, 0.40, 100, 80),
(146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.345268', '1997-01-05', 'SA_MAN', 13500, 0.30, 100, 80),
(147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', '1997-03-10', 'SA_MAN', 12000, 0.30, 100, 80),
(148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', '1997-10-15', 'SA_MAN', 11000, 0.25, 100, 80),
(149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '1998-01-29', 'SA_MAN', 10500, 0.20, 100, 80),
(150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', '1998-01-30', 'SA_REP', 10000, 0.30, 145, 80),
(151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', '1998-03-24', 'SA_REP', 9500, 0.25, 145, 80),
(152, 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', '1998-08-20', 'SA_REP', 9000, 0.25, 145, 80),
(153, 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.498718', '1999-03-30', 'SA_REP', 8000, 0.20, 145, 80),
(154, 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', '1999-12-09', 'SA_REP', 7500, 0.20, 145, 80),
(155, 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', '1999-11-23', 'SA_REP', 7000, 0.15, 145, 80),
(156, 'Janette', 'King', 'JKING', '011.44.1345.429268', '1996-01-30', 'SA_REP', 10000, 0.35, 146, 80),
(157, 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', '1996-03-04', 'SA_REP', 9500, 0.35, 146, 80),
(158, 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', '1996-08-01', 'SA_REP', 9000, 0.35, 146, 80),
(159, 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', '1997-03-10', 'SA_REP', 8000, 0.30, 146, 80),
(160, 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', '1997-12-15', 'SA_REP', 7500, 0.30, 146, 80),
(161, 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', '1998-11-03', 'SA_REP', 7000, 0.25, 146, 80),
(162, 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', '1997-11-11', 'SA_REP', 10500, 0.25, 147, 80),
(163, 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', '1999-03-19', 'SA_REP', 9500, 0.15, 147, 80),
(164, 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.329268', '2000-01-24', 'SA_REP', 7200, 0.10, 147, 80),
(165, 'David', 'Lee', 'DLEE', '011.44.1346.529268', '2000-02-23', 'SA_REP', 6800, 0.10, 147, 80),
(166, 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', '2000-03-24', 'SA_REP', 6400, 0.10, 147, 80),
(167, 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', '2000-04-21', 'SA_REP', 6200, 0.10, 147, 80),
(168, 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', '1997-03-11', 'SA_REP', 11500, 0.25, 148, 80),
(169, 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', '1998-03-23', 'SA_REP', 10000, 0.20, 148, 80),
(170, 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', '1998-01-24', 'SA_REP', 9600, 0.20, 148, 80),
(171, 'William', 'Smith', 'WSMITH', '011.44.1343.629268', '1999-02-23', 'SA_REP', 7400, 0.15, 148, 80),
(172, 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', '1999-03-24', 'SA_REP', 7300, 0.15, 148, 80),
(173, 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', '2000-04-21', 'SA_REP', 6100, 0.10, 148, 80),
(174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', '1996-05-11', 'SA_REP', 11000, 0.30, 149, 80),
(175, 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', '1997-03-19', 'SA_REP', 8800, 0.25, 149, 80),
(176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', '1998-03-24', 'SA_REP', 8600, 0.20, 149, 80),
(177, 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', '1998-04-23', 'SA_REP', 8400, 0.20, 149, 80),
(178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', '1999-05-24', 'SA_REP', 7000, 0.15, 149, NULL),
(179, 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', '2000-01-04', 'SA_REP', 6200, 0.10, 149, 80),
(180, 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', '1998-01-24', 'SH_CLERK', 3200, NULL, 120, 50),
(181, 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', '1998-02-23', 'SH_CLERK', 3100, NULL, 120, 50),
(182, 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', '1999-06-21', 'SH_CLERK', 2500, NULL, 120, 50),
(183, 'Girard', 'Geoni', 'GGEONI', '650.507.9879', '2000-02-03', 'SH_CLERK', 2800, NULL, 120, 50),
(184, 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', '1996-01-27', 'SH_CLERK', 4200, NULL, 121, 50),
(185, 'Alexis', 'Bull', 'ABULL', '650.509.2876', '1997-02-20', 'SH_CLERK', 4100, NULL, 121, 50),
(186, 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', '1998-06-24', 'SH_CLERK', 3400, NULL, 121, 50),
(187, 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', '1999-02-07', 'SH_CLERK', 3000, NULL, 121, 50),
(188, 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', '1997-06-14', 'SH_CLERK', 3800, NULL, 122, 50),
(189, 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', '1997-08-13', 'SH_CLERK', 3600, NULL, 122, 50),
(190, 'Timothy', 'Gates', 'TGATES', '650.505.3876', '1998-07-11', 'SH_CLERK', 2900, NULL, 122, 50),
(191, 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', '1999-12-19', 'SH_CLERK', 2500, NULL, 122, 50),
(192, 'Sarah', 'Bell', 'SBELL', '650.501.1876', '1996-02-04', 'SH_CLERK', 4000, NULL, 123, 50),
(193, 'Britney', 'Everett', 'BEVERETT', '650.501.2876', '1997-03-03', 'SH_CLERK', 3900, NULL, 123, 50),
(194, 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', '1998-07-01', 'SH_CLERK', 3200, NULL, 123, 50),
(195, 'Vance', 'Jones', 'VJONES', '650.501.4876', '1999-03-17', 'SH_CLERK', 2800, NULL, 123, 50),
(196, 'Alana', 'Walsh', 'AWALSH', '650.507.9811', '1998-04-24', 'SH_CLERK', 3100, NULL, 124, 50),
(197, 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', '1998-05-23', 'SH_CLERK', 3000, NULL, 124, 50),
(198, 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', '1999-06-21', 'SH_CLERK', 2600, NULL, 124, 50),
(199, 'Douglas', 'Grant', 'DGRANT', '650.507.9844', '2000-01-13', 'SH_CLERK', 2600, NULL, 124, 50),
(200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', '1987-09-17', 'AD_ASST', 4400, NULL, 101, 10),
(201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', '1996-02-17', 'MK_MAN', 13000, NULL, 100, 20),
(202, 'Pat', 'Fay', 'PFAY', '603.123.6666', '1997-08-17', 'MK_REP', 6000, NULL, 201, 20),
(203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', '1994-06-07', 'HR_REP', 6500, NULL, 101, 40),
(204, 'Hermann', 'Baer', 'HBAER', '515.123.8888', '1994-06-07', 'PR_REP', 10000, NULL, 101, 70),
(205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', '1994-06-07', 'AC_MGR', 12000, NULL, 101, 110),
(206, 'William', 'Gietz', 'WGIETZ', '51hr5.123.8181', '1994-06-07', 'AC_ACCOUNT', 8300, NULL, 205, 110);
commit; 
-- --------------------------------------------------
-- INSERT into job_history table
-- --------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
VALUES
(102, '2001-01-13', '2006-07-24', 'IT_PROG', 60),
(101, '2005-09-21', '2007-10-27', 'AC_ACCOUNT', 110),
(101, '2007-10-28', '2008-12-31', 'AC_MGR', 110),
(201, '2004-02-17', '2007-12-19', 'MK_REP', 20),
(114, '2006-03-24', '2007-12-31', 'ST_CLERK', 50),
(122, '2007-01-01', '2007-12-31', 'SH_CLERK', 50),
(176, '2006-03-24', '2006-12-31', 'SA_REP', 80),
(200, '1995-09-17', '2001-06-17', 'AD_ASST', 90);
SET FOREIGN_KEY_CHECKS = 1;
commit;

-- Tables from Database tables.docx
SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM salesman;
SELECT * FROM emp_details;
SELECT * FROM item_mast;


-- Tables from HRDB.docx
SELECT * FROM regions;
SELECT * FROM countries;
SELECT * FROM locations;
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM employees;
SELECT * FROM job_history;

-- View from HRDB
SELECT * FROM emp_details_view;

-- -- 1. write a SQL query to find customers who are either from the city 'NewYork' or 
-- who do not have a grade greater than 100. Return customer_id, cust_name, city, grade, and salesman_id.  

select customer_id,cust_name,city,grade,salesman_id
from customer where city = 'newyork' or grade <= 100;

-- 2. write a SQL query to find all the customers in ‘New York’ city who have agradevalue above 100. 
--    Return customer_id, cust_name, city, grade, and salesman_id.,

 select customer_id, cust_name, city, grade,salesman_id
 from customer 
 where city = 'New York' and grade>100;
 
 -- 3. Write a SQL query that displays order number, purchase amount, and the
--   achieved and unachieved percentage (%) for those orders that exceed 50%of thetarget value of 6000.

select ord_no,purch_amt,round((purch_amt / 6000) * 100, 2) as achieved_percentage,
round(100 - (purch_amt / 6000) * 100, 2) as unachieved_percentage
from orders where (purch_amt / 6000) * 100 > 50;

-- 4. write a SQL query to calculate the total purchase amount of all orders. Return total purchase amount.--

select sum(purch_amt) as total_purchase_amount from orders;

--  5. write a SQL query to find the highest purchase amount ordered by each customer. 
--    Return customer ID, maximum purchase amount

select customer_id,max(purch_amt) as maximum_purchase_amount from orders group by customer_id order by maximum_purchase_amount;

-- 6. write a SQL query to calculate the average product price. Return average product price.

select round(avg(pro_price),2) as avgprice from item_mast;

-- 7.write a SQL query to find those employees whose department is located at ‘Toronto’. 
-- Return first name, last name, employee ID, job ID.

select e.first_name,e.last_name,e.employee_id,e.job_id
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
where l.city = 'Toronto';


-- 8. write a SQL query to find those employees whose salary is lower than that of
--    employees whose job title is "MK_MAN". Exclude employees of the Jobtitle‘MK_MAN’. 
--    Return employee ID, first name, last name, job ID.

select employee_id, first_name, last_name, job_id
from employees
where salary < (select max(salary)
from employees where job_id = 'MK_MAN')and job_id <> 'MK_MAN';

SELECT employee_id, first_name, last_name, job_id
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
    WHERE job_id = 'MK_MAN'
)
AND job_id <> 'MK_MAN';

SELECT employee_id, first_name, last_name, job_id
FROM employees
WHERE salary < (
    SELECT MIN(salary)
    FROM employees
    WHERE job_id = 'MK_MAN'
)
AND job_id != 'MK_MAN';


--  9. write a SQL query to find all those employees who work in department ID80or40.
--  Return first name, last name, department number and department name.
 
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id
where e.department_id in (80, 40);

 
--  10.write a SQL query to calculate the average salary, the number of employees

select d.department_name , round(avg(e.salary),2) avgsalary ,count(e.commission_pct) numofemployee
from employees e
join departments d
on e.department_id = d.department_id 
group by d.department_name;

--  11.write a SQL query to find out which employees have the same designationas theemployee whose ID is 169. Return first name, last name, department IDandjobID.

select first_name, last_name, department_id, job_id
from employees
where job_id = (select job_id from employees where employee_id = 169);
	

--  12.write a SQL query to find those employees who earn more than the averagesalary. 
--   Return employee ID, first name, last name. 

select employee_id, first_name, last_name
from employees
where salary > (select avg(salary) from employees);


--  13.write a SQL query to find all those employees who work in the Finance
--  department. Return department ID, name (first), job ID and department name. 
	
select e.department_id,e.first_name,e.job_id,d.department_name
from employees e
join departments d ON e.department_id = d.department_id
where d.department_name = 'Finance';


--  14. From the following table, write a SQL query to find the employees whoearnlessthan the employee of ID 182. 
--   Return first name, last name and salary.

select first_name, last_name, salary
from employees
where salary < (select salary from employees where employee_id = 182);


 -- 15.Create a stored procedure CountEmployeesByDept that returns the number of employees in each department
DELIMITER //

create procedure CountEmployeesByDept()
begin
    select 
        d.department_id,
        d.department_name,
        count(e.employee_id) as employee_count
    from
        departments d
    left join
        employees e on d.department_id = e.department_id
    group by 
        d.department_id, d.department_name
 order by 
        d.department_id;
end //
DELIMITER ;

call CountEmployeesByDept();

--  16.Create a stored procedure AddNewEmployee that adds a new employee tothedatabase. 

DELIMITER //

create procedure AddNewEmployee (
    in p_employee_id int,
    in p_first_name varchar(20),
    in p_last_name varchar(25),
    in p_email varchar(25),
    in p_phone_number varchar(20),
    in p_hire_date date,
    in p_job_id varchar(10),
    in p_salary decimal(8,2),
    in p_commission_pct decimal(5,2),
    in p_manager_id int,
    in p_department_id int
)
BEGIN
    -- Insert the new employee
    INSERT INTO employees (
        employee_id, first_name, last_name, email, phone_number, hire_date,
        job_id, salary, commission_pct, manager_id, department_id
    )
    VALUES (
        p_employee_id, p_first_name, p_last_name, p_email, p_phone_number, p_hire_date,
        p_job_id, p_salary, p_commission_pct, p_manager_id, p_department_id
    );

    -- Output message
    SELECT CONCAT('Employee ', p_first_name, ' ', p_last_name, ' added successfully.') AS result;
END //

DELIMITER ;

call AddNewEmployee(210, 'alice', 'bob', 'HBAER', '515.123.8888', '1994-09-08', 'PR_REP', 10000, NULL, 101, 70);

--  17.Create a stored procedure DeleteEmployeesByDept that removes all employeesfrom a specific department

DELIMITER //

CREATE PROCEDURE DeleteEmployeesByDept (
    IN dept_id INT
)
BEGIN
    DECLARE deleted_count INT;

    -- Count how many employees will be deleted
    SELECT COUNT(*) INTO deleted_count
    FROM employees
    WHERE department_id = dept_id;

    -- Delete the employees
    DELETE FROM employees
    WHERE department_id = dept_id;

    -- Output how many employees were deleted
    SELECT CONCAT('Number of employees deleted: ', deleted_count) AS result;
END// 

DELIMITER ;

CALL DeleteEmployeesByDept();

--  18.Create a stored procedure GetTopPaidEmployees that retrieves the highest-paidemployee in each department. 

DELIMITER //

CREATE PROCEDURE GetTopPaidEmployees()
BEGIN
    SELECT e.department_id,
           d.department_name,
           e.employee_id,
           CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
           e.salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE (e.department_id, e.salary) IN (
        SELECT department_id, MAX(salary)
        FROM employees
        GROUP BY department_id
    )
    ORDER BY e.department_id;
END //

DELIMITER ;


--  19.Create a stored procedure PromoteEmployee that increases an employee’s salaryand changes their job role. 

DELIMITER //

CREATE PROCEDURE PromoteEmployee(
    IN p_employee_id INT,
    IN p_new_salary DECIMAL(8,2),
    IN p_new_job_id VARCHAR(10)
)
BEGIN
    -- Declare variables to store old values
    DECLARE v_old_salary DECIMAL(8,2);
    DECLARE v_old_job_id VARCHAR(10);

    -- Check if employee exists
    IF EXISTS (SELECT 1 FROM employees WHERE employee_id = p_employee_id) THEN
        
        -- Get current salary and job
        SELECT salary, job_id
        INTO v_old_salary, v_old_job_id
        FROM employees
        WHERE employee_id = p_employee_id;

        -- Update the employee record
        UPDATE employees
        SET salary = p_new_salary,
            job_id = p_new_job_id
        WHERE employee_id = p_employee_id;

        -- Output confirmation and updated data
        SELECT 
            CONCAT('Employee ', p_employee_id, ' promoted from job ', v_old_job_id, 
                   ' (salary: ', v_old_salary, ') to job ', p_new_job_id,
                   ' (salary: ', p_new_salary, ').') AS PromotionStatus;

        -- Return updated employee info
        SELECT employee_id, first_name, last_name, job_id, salary
        FROM employees
        WHERE employee_id = p_employee_id;

    ELSE
        -- If employee does not exist
        SELECT CONCAT('Employee with ID ', p_employee_id, ' does not exist.') AS PromotionStatus;
    END IF;
END //

DELIMITER ;


--  20.Create a stored procedure AssignManagerToDepartment that assigns a newmanager to all employees in a specific department


DELIMITER //

CREATE PROCEDURE AssignManagerToDepartment (
    IN dept_id INT,
    IN new_manager_id INT,
    OUT affected_count INT
)
BEGIN
    -- Update manager_id for all employees in the specified department
    UPDATE employees
    SET manager_id = new_manager_id
    WHERE department_id = dept_id;

    -- Return number of rows updated
    SET affected_count = ROW_COUNT();
END //

DELIMITER ;
