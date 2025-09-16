-- ============================================
-- SummitInventory • Sample Data
-- ============================================

-- Products
INSERT INTO Products (product_id, product_name, unit_price, stock_qty, min_stock, status) VALUES
(1,  'Granola Bar',             1.50,  50, 10, 'IN_STOCK');
INSERT INTO Products VALUES (2,  'Mountain Spring Water 1L', 0.90,  8,  12, 'LOW');
INSERT INTO Products VALUES (3,  'Trail Mix 500g',           4.20,  0,  5,  'OUT');
INSERT INTO Products VALUES (4,  'Hiking Socks',             6.00,  5,  5,  'IN_STOCK');

-- Orders
INSERT INTO Orders (order_id, order_date, customer) VALUES (1001, SYSDATE, 'Evergreen Outfitters');
INSERT INTO Orders (order_id, order_date, customer) VALUES (1002, SYSDATE, 'Summit Co-Op');

-- OrderDetails (use snapshot unit_price for auditability)
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1001, 1, 20, 1.50);
INSERT INTO OrderDetails VALUES (2, 1001, 2,  5, 0.90);
INSERT INTO OrderDetails VALUES (3, 1002, 4,  2, 6.00);

COMMIT;
