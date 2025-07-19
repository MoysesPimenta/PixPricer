CREATE TABLE items (
  id TEXT PRIMARY KEY NOT NULL,
  ts INTEGER NOT NULL,
  price_unit REAL NOT NULL,
  quantity REAL NOT NULL,
  discount_rule TEXT
);
