PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  full_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'member',
  verified INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS profiles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL UNIQUE,
  display_name TEXT NOT NULL,
  category TEXT NOT NULL,
  bio TEXT,
  location TEXT,
  social_link TEXT,
  profile_image TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS interests (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  interest_name TEXT NOT NULL,
  FOREIGN KEY(user_id) REFERENCES users(id),
  UNIQUE(user_id, interest_name)
);

CREATE TABLE IF NOT EXISTS vouchers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  voucher_type TEXT NOT NULL,
  price_cents INTEGER NOT NULL,
  credit_value INTEGER NOT NULL DEFAULT 0,
  duration_days INTEGER DEFAULT 0,
  active INTEGER DEFAULT 1
);

CREATE TABLE IF NOT EXISTS voucher_codes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  voucher_id INTEGER NOT NULL,
  code TEXT NOT NULL UNIQUE,
  status TEXT DEFAULT 'unused',
  purchased_by INTEGER,
  redeemed_by INTEGER,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  redeemed_at DATETIME,
  FOREIGN KEY(voucher_id) REFERENCES vouchers(id),
  FOREIGN KEY(purchased_by) REFERENCES users(id),
  FOREIGN KEY(redeemed_by) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS wallets (
  user_id INTEGER PRIMARY KEY,
  balance INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  amount INTEGER NOT NULL,
  transaction_type TEXT NOT NULL,
  description TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS campaigns (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  category TEXT NOT NULL,
  audience TEXT,
  budget INTEGER NOT NULL DEFAULT 0,
  status TEXT DEFAULT 'pending',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS redemptions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  voucher_code_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  service TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(voucher_code_id) REFERENCES voucher_codes(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO vouchers
(name, voucher_type, price_cents, credit_value, duration_days)
VALUES
('Starter Voucher','promotion',1000,100,3),
('Growth Voucher','promotion',2500,280,7),
('Business Voucher','visibility',5000,600,14),
('Premium Voucher','premium',10000,1300,30);
