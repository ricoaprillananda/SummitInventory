-- ============================================
-- SummitInventory • Schema Definition
-- ============================================

-- Drop in dependency order for clean re-runs
BEGIN EXECUTE IMMEDIATE 'DROP TABLE OrderDetails PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Orders PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Products PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/

-- Products: catalog with price and stock thresholds
CREATE TABLE Products (
  product_id   NUMBER         PRIMARY KEY,
  product_name VARCHAR2(150)  NOT NULL,
  unit_price   NUMBER(12,2)   NOT NULL CHECK (unit_price >= 0),
  stock_qty    NUMBER         NOT NULL CHECK (stock_qty >= 0),
  min_stock    NUMBER         NOT NULL CHECK (min_stock >= 0),
  status       VARCHAR2(20)   DEFAULT 'IN_STOCK' CHECK (status IN ('IN_STOCK','LOW','OUT'))
);

-- Orders: header table
CREATE TABLE Orders (
  order_id     NUMBER         PRIMARY KEY,
  order_date   DATE           DEFAULT SYSDATE NOT NULL,
  customer     VARCHAR2(150)  NOT NULL
);

-- OrderDetails: line items
CREATE TABLE OrderDetails (
  order_detail_id NUMBER       PRIMARY KEY,
  order_id        NUMBER       NOT NULL REFERENCES Orders(order_id),
  product_id      NUMBER       NOT NULL REFERENCES Products(product_id),
  quantity        NUMBER       NOT NULL CHECK (quantity > 0),
  unit_price      NUMBER(12,2) NOT NULL CHECK (unit_price >= 0)
);

-- Helpful indexes
CREATE INDEX idx_od_order   ON OrderDetails(order_id);
CREATE INDEX idx_od_product ON OrderDetails(product_id);
