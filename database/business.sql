PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS payments (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 user_id INTEGER NOT NULL,
 reference TEXT UNIQUE NOT NULL,
 amount_cents INTEGER NOT NULL,
 provider TEXT NOT NULL,
 status TEXT DEFAULT 'pending',
 confirmed_at DATETIME,
 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS voucher_purchases (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 user_id INTEGER NOT NULL,
 voucher_id INTEGER NOT NULL,
 payment_id INTEGER,
 voucher_code_id INTEGER,
 amount_paid INTEGER NOT NULL,
 status TEXT DEFAULT 'pending',
 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(user_id) REFERENCES users(id),
 FOREIGN KEY(voucher_id) REFERENCES vouchers(id),
 FOREIGN KEY(payment_id) REFERENCES payments(id),
 FOREIGN KEY(voucher_code_id) REFERENCES voucher_codes(id)
);

CREATE TABLE IF NOT EXISTS platform_revenue (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 payment_id INTEGER NOT NULL,
 gross_amount INTEGER NOT NULL,
 refund_amount INTEGER DEFAULT 0,
 net_amount INTEGER NOT NULL,
 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(payment_id) REFERENCES payments(id)
);

CREATE TABLE IF NOT EXISTS voucher_usage (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 voucher_code_id INTEGER NOT NULL,
 service_name TEXT NOT NULL,
 usage_status TEXT DEFAULT 'active',
 starts_at DATETIME,
 expires_at DATETIME,
 FOREIGN KEY(voucher_code_id) REFERENCES voucher_codes(id)
);

CREATE INDEX IF NOT EXISTS idx_payments_user
ON payments(user_id);

CREATE INDEX IF NOT EXISTS idx_vouchers_status
ON voucher_codes(status);

CREATE INDEX IF NOT EXISTS idx_campaigns_status
ON campaigns(status);
