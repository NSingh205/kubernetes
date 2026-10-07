-- ============================================================
-- ShopKart database schema  (MySQL 8)
-- Step 1: this file creates the EMPTY tables (the "shelves").
-- File 02-seed.sql then puts sample data on the shelves.
-- ============================================================

CREATE DATABASE IF NOT EXISTS shopkart
  CHARACTER SET utf8mb4          -- supports all languages + emoji
  COLLATE utf8mb4_unicode_ci;
USE shopkart;

-- ---------- USERS: people who register on the site ----------
CREATE TABLE users (
  id            INT UNSIGNED  NOT NULL AUTO_INCREMENT,   -- unique number per user, MySQL counts 1,2,3...
  name          VARCHAR(100)  NOT NULL,
  email         VARCHAR(150)  NOT NULL,
  password_hash VARCHAR(255)  NOT NULL,                  -- NEVER store the real password, only a hash
  role          ENUM('customer','admin') NOT NULL DEFAULT 'customer',
  created_at    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_users_email (email)                      -- two users cannot share one email
) ENGINE=InnoDB;

-- ---------- CATEGORIES: Electronics, Books, ... ----------
CREATE TABLE categories (
  id    INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name  VARCHAR(100) NOT NULL,
  slug  VARCHAR(100) NOT NULL,                           -- url-friendly name, e.g. "home-kitchen"
  PRIMARY KEY (id),
  UNIQUE KEY uq_categories_slug (slug)
) ENGINE=InnoDB;

-- ---------- PRODUCTS: the things we sell ----------
CREATE TABLE products (
  id           INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  category_id  INT UNSIGNED  NOT NULL,
  name         VARCHAR(200)  NOT NULL,
  description  TEXT          NOT NULL,
  price        DECIMAL(10,2) NOT NULL,                   -- DECIMAL (not FLOAT) for money: exact, no rounding surprises
  stock        INT UNSIGNED  NOT NULL DEFAULT 0,
  image_url    VARCHAR(255)  NOT NULL,
  created_at   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_products_category (category_id),
  -- FOREIGN KEY = a product MUST belong to a category that really exists
  CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories (id)
) ENGINE=InnoDB;

-- ---------- CART_ITEMS: what each user currently has in their cart ----------
CREATE TABLE cart_items (
  id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id     INT UNSIGNED NOT NULL,
  product_id  INT UNSIGNED NOT NULL,
  quantity    INT UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE KEY uq_cart_user_product (user_id, product_id), -- same product twice = increase quantity, not a 2nd row
  CONSTRAINT fk_cart_user    FOREIGN KEY (user_id)    REFERENCES users (id)    ON DELETE CASCADE,
  CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------- ORDERS: one row per checkout ----------
CREATE TABLE orders (
  id               INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  user_id          INT UNSIGNED  NOT NULL,
  total            DECIMAL(10,2) NOT NULL,
  status           ENUM('pending','paid','shipped','delivered','cancelled') NOT NULL DEFAULT 'pending',
  shipping_address TEXT          NOT NULL,
  created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_orders_user (user_id),
  CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE=InnoDB;

-- ---------- ORDER_ITEMS: the products inside each order ----------
CREATE TABLE order_items (
  id          INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  order_id    INT UNSIGNED  NOT NULL,
  product_id  INT UNSIGNED  NOT NULL,
  quantity    INT UNSIGNED  NOT NULL,
  unit_price  DECIMAL(10,2) NOT NULL,   -- price AT THE TIME of purchase (product price may change later!)
  PRIMARY KEY (id),
  KEY idx_order_items_order (order_id),
  CONSTRAINT fk_oi_order   FOREIGN KEY (order_id)   REFERENCES orders (id)   ON DELETE CASCADE,
  CONSTRAINT fk_oi_product FOREIGN KEY (product_id) REFERENCES products (id)
) ENGINE=InnoDB;
