DROP TABLE events;

-- How to store events data?
-- 1. Creating a table
CREATE TABLE events (
    id INTEGER PRIMARY KEY,
    title TEXT,
    description TEXT,
    start_datetime DATETIME,
    end_datetime DATETIME
);

-- How to add events to the table?
-- 2. Inserting data into newly created table
INSERT INTO events (title, description, start_datetime, end_datetime)
VALUES ('Introdução ao SQL', 'Oficina de Introdução ao SQL', '2025-04-22 19:30:00', '2025-04-22 22:00:00'),
       ('Trabalhe no LHC', 'Dia de trabalhar no LHC', '2025-04-30 09:00:00', '2025-04-30 17:00:00'),
       ('Global Azure - DOUGBrazil', 'Encontro #GlobalAzure2025', '2025-05-10 09:00:00', '2025-05-10 17:00:00'),
       ('Reunião mensal do LHC', 'Nossa reunião', '2025-05-12 19:30:00', '2025-05-12 20:30:00'),
       ('Reunião mensal do LHC', 'Nossa reunião', '2025-06-09 19:30:00', '2025-06-09 20:30:00')
       ('Oficina de IoT', 'Oficina mensal', '2025-06-11 19:30:00', '2025-06-11 21:00:00');


-- How to list all events that we have stored?
-- 3. Selecting all events
SELECT * FROM events;

-- How to select just some info about the events?
-- 4 Select specific columns
SELECT id, title, start_datetime FROM events;

-- How to sort the results?
-- 5 Using ORDER BY
SELECT * FROM events ORDER BY title;
SELECT * FROM events ORDER BY title DESC;
SELECT * FROM events ORDER BY title ASC;

-- Do we have distinct event names?
-- 5. SELECT DISTINCT
SELECT DISTINCT title FROM events;

-- What are events after 01/05?
-- 6. WHERE >
SELECT title, start_datetime FROM events WHERE start_datetime > '2025-05-01';
-- Does it work?
SELECT title, start_datetime FROM events WHERE start_datetime = '2025-04-30';

-- Quais os eventos no dia 30/04?
-- Format date field
SELECT title, start_datetime FROM events WHERE strftime('%Y-%m-%d', start_datetime) = '2025-04-30';

-- Quando vamos ter reuniões mensais?
SELECT title, start_datetime, end_datetime FROM events WHERE title = 'Reunião mensal do LHC';

-- SQLite only is case-insensitive
SELECT title, start_datetime, end_datetime FROM events WHERE title LIKE '%LHC';
SELECT title, start_datetime, end_datetime FROM events WHERE title LIKE '%lhc';


-- Quais eventos do mês de maio?
SELECT
    id, title, start_datetime, end_datetime
FROM
    events
WHERE
    title = 'Reunião mensal do LHC'
    AND strftime('%Y-%m', start_datetime) = '2025-05';
    
-- De maio ou que o titulo tenha LHC
SELECT
    id, title, start_datetime, end_datetime
FROM
    events
WHERE
    title LIKE '%LHC'
    OR strftime('%Y-%m', start_datetime) = '2025-05';

-- Quais os eventos entre 15/04 e 14/05
SELECT
    title, start_datetime
FROM
    events
WHERE
    start_datetime BETWEEN '2025-04-15' AND '2025-05-14'


-- Quantos eventos no total?

------------------

CREATE TABLE transactions (
    id INTEGER PRIMARY KEY,
    date date NOT NULL,
    description TEXT NOT NULL,
    amount NUMERIC NOT NULL,
    cash_book_id INTEGER
);

INSERT INTO transactions (date, description, amount, cash_book_id) VALUES
('2024-01-10', 'Mensalidade - Janeiro', 50.00, 1),
('2024-02-12', 'Compra de ferramentas', -120.00, 2),
('2024-03-05', 'Oficina: Introdução ao Linux (inscrição)', 40.00, 1),
('2024-03-28', 'Conta de água - Março', -60.50, 3),
('2024-04-15', 'Doação anônima via Pix', 150.00, 2),
('2024-05-09', 'Compra de sensores para robótica', -90.00, 1),
('2024-06-18', 'Venda de camiseta do hackerspace', 25.00, 2),
('2024-07-07', 'Reembolso por peças de impressora 3D', -55.75, 1),
('2024-08-22', 'Aluguel do espaço - Agosto', -500.00, 3),
('2024-09-01', 'Mensalidade - Setembro', 50.00, 1),
('2024-10-05', 'Compra de roteador', -180.00, 3),
('2024-11-12', 'Evento: Noite do Hardware Livre (doações)', 95.00, 2),
('2024-12-20', 'Conta de energia - Dezembro', -78.40, 3),
('2025-01-10', 'Mensalidade - Janeiro', 50.00, 1),
('2025-02-15', 'Compra de componentes eletrônicos', -110.00, 2),
('2025-03-03', 'Oficina: Programação com Python (inscrição)', 60.00, 1),
('2025-04-08', 'Compra de café e materiais de limpeza', -38.90, 2),
('2025-05-17', 'Venda de Arduino usado', 80.00, 2),
('2025-06-25', 'Aluguel do espaço - Junho', -500.00, 3),
('2025-07-04', 'Mensalidade - Julho', 50.00, 1);

-- saldo final de 2024
select sum(amount) as saldo_2025 from transactions where date >= '2025-01-01';

-- saldo atual de 2025
select sum(amount) as saldo_2025 from transactions where date >= '2025-01-01';

-- média das depesas em 2024 e 2025
-- mediana das depesas em 2024 e 2025
-- percentil (não existe mediana em ANSI SQL)



CREATE TABLE summary (
    expenses_2024 NUMERIC,
    expenses_2025 NUMERIC,
    incomes_2024 NUMERIC,
    incomes_2025 NUMERIC,
);

SELECT FROM
    (SELECT SUM(amount) FROM transactions WHERE amount < 0 AND strftime('%Y', date) = '2024') AS expenses_2024,
    (SELECT SUM(amount) FROM transactions WHERE amount < 0 AND strftime('%Y', date) = '2025') AS expenses_2025,
    (SELECT SUM(amount) FROM transactions WHERE amount > 0 AND strftime('%Y', date) = '2024') AS incomes_2024,
    (SELECT SUM(amount) FROM transactions WHERE amount > 0 AND strftime('%Y', date) = '2025') AS incomes_2025;

INSERT INTO summary (
    expenses_2024, expenses_2025, incomes_2024, incomes_2025)
VALUES
    (1084.65, 648.90, 410.00, 240.00);

INSERT INTO summary (expenses_2024, expenses_2025, incomes_2024, incomes_2025)
VALUES (
    (SELECT SUM(amount) FROM transactions WHERE amount < 0 AND strftime('%Y', date) = '2024'),
    (SELECT SUM(amount) FROM transactions WHERE amount < 0 AND strftime('%Y', date) = '2025'),
    (SELECT SUM(amount) FROM transactions WHERE amount > 0 AND strftime('%Y', date) = '2024'),
    (SELECT SUM(amount) FROM transactions WHERE amount > 0 AND strftime('%Y', date) = '2025')
);

-- percentual das despesas em 2024
-- percentual das despesas em 2025
-- percentual das receitas em 2024
-- percentual das receitas em 2025
-- variaçao percentual das receitas de 2024 para 2025
-- variaçao percentual das despesas de 2024 para 2025
-- 1. Percentual das despesas em 2024
SELECT
    (expenses_2024 * 100.0 / (expenses_2024 + expenses_2025)) AS percentage_expenses_2024
FROM summary;

-- 2. Percentual das despesas em 2025
SELECT
    (expenses_2025 * 100.0 / (expenses_2024 + expenses_2025)) AS percentage_expenses_2025
FROM summary;

-- 3. Percentual das receitas em 2024
SELECT
    (incomes_2024 * 100.0 / (incomes_2024 + incomes_2025)) AS percentage_incomes_2024
FROM summary;

-- 4. Percentual das receitas em 2025
SELECT
    (incomes_2025 * 100.0 / (incomes_2024 + incomes_2025)) AS percentage_incomes_2025
FROM summary;

-- 5. Variação percentual das receitas de 2024 para 2025
SELECT
    ((incomes_2025 - incomes_2024) * 100.0 / incomes_2024) AS variation_percentage_incomes
FROM summary;


-- quantos eventos no total