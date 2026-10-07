-- ============================================================
-- ShopKart sample data (prices in Indian Rupees)
-- Runs AFTER 01-schema.sql (files run in alphabetical order).
-- ============================================================
USE shopkart;

INSERT INTO categories (name, slug) VALUES
  ('Electronics',    'electronics'),
  ('Books',          'books'),
  ('Clothing',       'clothing'),
  ('Home & Kitchen', 'home-kitchen');

-- category ids above are 1=Electronics, 2=Books, 3=Clothing, 4=Home & Kitchen
INSERT INTO products (category_id, name, description, price, stock, image_url) VALUES
  (1, 'Wireless Bluetooth Headphones', 'Over-ear headphones with 30-hour battery life and deep bass.',            2499.00, 50, 'images/headphones.svg'),
  (1, 'Smart Watch Series 5',          'Fitness tracker with heart-rate monitor, GPS and 7-day battery.',         3999.00, 30, 'images/smartwatch.svg'),
  (1, 'Portable Power Bank 20000mAh',  'Fast-charging power bank with two USB ports and a digital display.',      1799.00, 80, 'images/powerbank.svg'),
  (2, 'Learn PHP the Easy Way',        'A beginner-friendly guide to building dynamic websites with PHP.',         499.00, 100, 'images/book-php.svg'),
  (2, 'Kubernetes in Simple Words',    'Understand clusters, pods and deployments with plain-language examples.',  699.00, 60, 'images/book-k8s.svg'),
  (2, 'The Art of SQL',                'Write faster, cleaner MySQL queries with real-world examples.',            549.00, 75, 'images/book-sql.svg'),
  (3, 'Men''s Cotton T-Shirt',         'Soft 100% cotton round-neck t-shirt, regular fit.',                        399.00, 200, 'images/tshirt.svg'),
  (3, 'Women''s Running Shoes',        'Lightweight breathable running shoes with cushioned sole.',               1999.00, 40, 'images/shoes.svg'),
  (3, 'Unisex Denim Jacket',           'Classic blue denim jacket with button closure.',                          2299.00, 25, 'images/jacket.svg'),
  (4, 'Stainless Steel Water Bottle',  'Keeps drinks cold for 24 hours and hot for 12 hours. 1 litre.',            699.00, 120, 'images/bottle.svg'),
  (4, 'Non-Stick Cookware Set',        '3-piece non-stick set: frying pan, kadhai and saucepan.',                 1899.00, 35, 'images/cookware.svg'),
  (4, 'LED Desk Lamp',                 'Dimmable LED lamp with 3 colour modes and a USB charging port.',           899.00, 60, 'images/lamp.svg');
