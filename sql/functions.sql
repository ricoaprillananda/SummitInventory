-- ============================================
-- SummitInventory • Aggregation Functions
-- ============================================

-- Drop function if present
BEGIN EXECUTE IMMEDIATE 'DROP FUNCTION Get_Order_Total'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -4043 THEN RAISE; END IF; END;
/

-- Get_Order_Total: returns the sum of line amounts for a given order
CREATE OR REPLACE FUNCTION Get_Order_Total (p_order_id IN NUMBER)
RETURN NUMBER
IS
  v_total NUMBER(14,2);
BEGIN
  SELECT NVL(SUM(od.quantity * od.unit_price), 0)
    INTO v_total
    FROM OrderDetails od
   WHERE od.order_id = p_order_id;

  RETURN v_total;
END Get_Order_Total;
/
SHOW ERRORS;
