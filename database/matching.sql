PRAGMA foreign_keys = ON;

-- Membership packages linked to vouchers
CREATE TABLE IF NOT EXISTS membership_plans (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 voucher_id INTEGER NOT NULL UNIQUE,
 plan_name TEXT NOT NULL,
 access_days INTEGER NOT NULL,
 FOREIGN KEY(voucher_id) REFERENCES vouchers(id)
);

-- Social media accounts
CREATE TABLE IF NOT EXISTS social_accounts (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 user_id INTEGER NOT NULL,
 platform TEXT NOT NULL,
 username TEXT NOT NULL,
 profile_url TEXT,
 verification_status TEXT DEFAULT 'unverified',
 FOREIGN KEY(user_id) REFERENCES users(id),
 UNIQUE(platform,username)
);

-- Audience requirements
CREATE TABLE IF NOT EXISTS audience_criteria (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 user_id INTEGER NOT NULL,
 platform TEXT NOT NULL,
 category TEXT NOT NULL,
 audience_type TEXT NOT NULL,
 country TEXT,
 language TEXT,
 interests TEXT,
 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(user_id) REFERENCES users(id)
);

-- Membership access
CREATE TABLE IF NOT EXISTS memberships (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 user_id INTEGER NOT NULL,
 voucher_code_id INTEGER NOT NULL UNIQUE,
 status TEXT DEFAULT 'active',
 starts_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 expires_at DATETIME NOT NULL,
 FOREIGN KEY(user_id) REFERENCES users(id),
 FOREIGN KEY(voucher_code_id) REFERENCES voucher_codes(id)
);

-- Matched profiles
CREATE TABLE IF NOT EXISTS profile_matches (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 criteria_id INTEGER NOT NULL,
 matched_user_id INTEGER NOT NULL,
 match_score INTEGER DEFAULT 0,
 match_status TEXT DEFAULT 'suggested',
 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(criteria_id) REFERENCES audience_criteria(id),
 FOREIGN KEY(matched_user_id) REFERENCES users(id),
 UNIQUE(criteria_id,matched_user_id)
);

-- Affiliate links
CREATE TABLE IF NOT EXISTS affiliate_links (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 user_id INTEGER NOT NULL,
 code TEXT NOT NULL UNIQUE,
 platform TEXT,
 category TEXT,
 destination_url TEXT,
 active INTEGER DEFAULT 1,
 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(user_id) REFERENCES users(id)
);

-- Affiliate referral tracking
CREATE TABLE IF NOT EXISTS referral_events (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 affiliate_link_id INTEGER NOT NULL,
 referred_user_id INTEGER,
 event_type TEXT NOT NULL,
 commission_cents INTEGER DEFAULT 0,
 status TEXT DEFAULT 'pending',
 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(affiliate_link_id) REFERENCES affiliate_links(id),
 FOREIGN KEY(referred_user_id) REFERENCES users(id)
);

CREATE INDEX IF NOT EXISTS idx_criteria_platform
ON audience_criteria(platform);

CREATE INDEX IF NOT EXISTS idx_matches_user
ON profile_matches(matched_user_id);

CREATE INDEX IF NOT EXISTS idx_referrals_link
ON referral_events(affiliate_link_id);

