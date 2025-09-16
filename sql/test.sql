-- ============================================
-- SummitInventory • End-to-End Test
-- ============================================

SET SERVEROUTPUT ON;

-- 1) Verify order totals
DECLARE
  v_total_1001 NUMBER;
  v_total_1002 NUMBER;
BEGIN
  v_total_1001 := Get_Order_Total(1001); -- (20*1.50) + (5*0.90) = 30 + 4.5 = 34.5
  v_total_1002 := Get_Order_Total(1002); -- (2*6.00) = 12
  DBMS_OUTPUT.PUT_LINE('Order 1001 total = ' || TO_CHAR(v_total_1001, 'FM999,999,990.00'));
  DBMS_OUTPUT.PUT_LINE('Order 1002 total = ' || TO_CHAR(v_total_1002, 'FM999,999,990.00'));
END;
/
-- Quick check
SELECT order_id, SUM(quantity*unit_price) AS calc_total
  FROM OrderDetails
 GROUP BY order_id
 ORDER BY order_id;

-- 2) Show products before restock (IDs 2 and 3 are below threshold)
SELECT product_id, product_name, stock_qty, min_stock, status
  FROM Products
 ORDER BY product_id;

-- 3) Run restock for low items (adds 10 units by default)
BEGIN
  Auto_Restock(10);
  DBMS_OUTPUT.PUT_LINE('Auto restock completed (+10 units per low item).');
END;
/

-- 4) Show products after restock with updated status
SELECT product_id, product_name, stock_qty, min_stock, status
  FROM Products
 ORDER BY product_id;
