-- ============================================
-- SummitInventory • Operational Procedures
-- ============================================

-- Drop procedure if present
BEGIN EXECUTE IMMEDIATE 'DROP PROCEDURE Auto_Restock'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -4043 THEN RAISE; END IF; END;
/

-- Auto_Restock:
--   Scans products below minimum stock and replenishes each by p_restock_qty.
--   Uses a cursor with FOR UPDATE to lock rows while updating stock and status.
CREATE OR REPLACE PROCEDURE Auto_Restock (p_restock_qty IN NUMBER DEFAULT 10) AS
  CURSOR c_low IS
    SELECT product_id, stock_qty, min_stock
      FROM Products
     WHERE stock_qty < min_stock
     FOR UPDATE OF stock_qty, status;
  v_new_qty NUMBER;
BEGIN
  IF NVL(p_restock_qty, 0) <= 0 THEN
    RAISE_APPLICATION_ERROR(-20010, 'Restock quantity must be positive');
  END IF;

  FOR r IN c_low LOOP
    v_new_qty := r.stock_qty + p_restock_qty;

    UPDATE Products
       SET stock_qty = v_new_qty,
           status    = CASE
                         WHEN v_new_qty = 0 THEN 'OUT'
                         WHEN v_new_qty < min_stock THEN 'LOW'
                         ELSE 'IN_STOCK'
                       END
     WHERE CURRENT OF c_low;
  END LOOP;

  COMMIT;
END Auto_Restock;
/
SHOW ERRORS;
