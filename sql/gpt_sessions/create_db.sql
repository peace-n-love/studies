-- ==========================================
-- 🧱 BI Practice Database v2
-- ==========================================

DROP TABLE IF EXISTS app_events CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS subscriptions CASCADE;
DROP TABLE IF EXISTS app_users CASCADE;

-- ----------------------------
-- USERS
-- ----------------------------
CREATE TABLE app_users (
    user_id SERIAL PRIMARY KEY,
    region  VARCHAR(50)
);

INSERT INTO app_users (region) VALUES
('Moscow'),
('Saint Petersburg'),
('Novosibirsk'),
('Ekaterinburg'),
('Kazan'),
('Moscow'),
('Rostov'),
('Perm'),
('Sochi'),
('Vladivostok');

-- ----------------------------
-- SUBSCRIPTIONS
-- ----------------------------
CREATE TABLE subscriptions (
    sub_id   SERIAL PRIMARY KEY,
    user_id  INT REFERENCES app_users(user_id),
    start_at DATE NOT NULL,
    end_at   DATE NOT NULL
);

-- несколько когорт: ранние, ушедшие, вернувшиеся
INSERT INTO subscriptions (user_id, start_at, end_at) VALUES
-- user 1 — постоянный
(1, '2024-01-01', '2024-01-31'),
(1, '2024-02-01', '2024-02-29'),
(1, '2024-03-01', '2024-03-31'),
(1, '2024-04-01', '2024-04-30'),
(1, '2024-05-01', '2024-05-31'),
(1, '2024-06-01', '2024-06-30'),

-- user 2 — ушёл весной
(2, '2024-01-10', '2024-02-09'),
(2, '2024-02-10', '2024-03-10'),

-- user 3 — поздний, активен осенью
(3, '2024-09-01', '2024-09-30'),
(3, '2024-10-01', '2024-10-31'),
(3, '2024-11-01', '2024-11-30'),

-- user 4 — нерегулярный, возвращается зимой
(4, '2024-03-15', '2024-04-14'),
(4, '2025-01-15', '2025-02-14'),

-- user 5 — одна подписка
(5, '2024-02-01', '2024-02-29'),

-- user 6 — стабильный, но пропускал
(6, '2024-01-20', '2024-02-19'),
(6, '2024-03-01', '2024-03-31'),
(6, '2024-04-01', '2024-04-30'),

-- user 7 — пробный, не вернулся
(7, '2024-05-10', '2024-06-09'),

-- user 8 — пришёл летом, остался
(8, '2024-07-01', '2024-07-31'),
(8, '2024-08-01', '2024-08-31'),
(8, '2024-09-01', '2024-09-30'),
(8, '2024-10-01', '2024-10-31'),
(8, '2024-11-01', '2024-11-30'),

-- user 9 — один раз в декабре
(9, '2024-12-01', '2024-12-31'),

-- user 10 — новый в 2025
(10, '2025-02-01', '2025-02-28'),
(10, '2025-03-01', '2025-03-31');

-- ----------------------------
-- PAYMENTS
-- ----------------------------
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    user_id    INT REFERENCES app_users(user_id),
    amount     NUMERIC(10,2) NOT NULL,
    created_at DATE NOT NULL
);

-- суммы разные, чтобы было что усреднять
INSERT INTO payments (user_id, amount, created_at) VALUES
(1, 10, '2024-01-01'),
(1, 10, '2024-02-01'),
(1, 12, '2024-03-01'),
(1, 10, '2024-04-01'),
(1, 15, '2024-05-01'),
(1, 15, '2024-06-01'),

(2, 10, '2024-01-10'),
(2, 10, '2024-02-10'),

(3, 10, '2024-09-01'),
(3, 10, '2024-10-01'),
(3, 10, '2024-11-01'),

(4, 8,  '2024-03-15'),
(4, 9,  '2025-01-15'),

(5, 7,  '2024-02-01'),

(6, 10, '2024-01-20'),
(6, 10, '2024-03-01'),
(6, 12, '2024-04-01'),

(7, 5,  '2024-05-10'),

(8, 9,  '2024-07-01'),
(8, 9,  '2024-08-01'),
(8, 10, '2024-09-01'),
(8, 10, '2024-10-01'),
(8, 12, '2024-11-01'),

(9, 8,  '2024-12-01'),

(10, 10, '2025-02-01'),
(10, 10, '2025-03-01');

-- ----------------------------
-- EVENTS (кликстрим)
-- ----------------------------
CREATE TABLE app_events (
    event_id  SERIAL PRIMARY KEY,
    user_id   INT REFERENCES app_users(user_id),
    event_type VARCHAR(30),
    event_time TIMESTAMP
);

INSERT INTO app_events (user_id, event_type, event_time) VALUES
(1, 'login', '2024-05-01 09:00'),
(1, 'view_page', '2024-05-01 09:05'),
(1, 'logout', '2024-05-01 09:10'),
(3, 'login', '2024-10-01 10:00'),
(3, 'view_page', '2024-10-01 10:02'),
(4, 'login', '2025-01-15 08:55'),
(4, 'purchase', '2025-01-15 09:05'),
(8, 'login', '2024-09-01 14:00'),
(8, 'view_page', '2024-09-01 14:10'),
(8, 'purchase', '2024-09-01 14:15'),
(10, 'login', '2025-03-01 12:00'),
(10, 'purchase', '2025-03-01 12:10');

-- ----------------------------
-- Проверка
-- ----------------------------
SELECT 'app_users' AS table_name, COUNT(*) FROM app_users
UNION ALL
SELECT 'subscriptions', COUNT(*) FROM subscriptions
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'events', COUNT(*) FROM app_events;
