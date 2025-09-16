# SummitInventory ☑️📱
SummitInventory is a PL/SQL system engineered to keep product flow at its peak. It unites products, orders, and order details in a structured schema, calculates order totals with precision, and ensures resilience through automated restock routines. Lightweight yet commanding, it delivers clarity and control for modern inventory management.

---

## Features

> Relational schema with three entities: Products, Orders, and OrderDetails.

> Order total function (Get_Order_Total) that aggregates line items into precise transaction totals.

> Cursor-based restock procedure (Auto_Restock) to replenish low-stock products and update availability status.

> Sample dataset to simulate real inventory and order flows.

> Comprehensive test script to validate calculations, restock logic, and business rules.

## Project Structure

```pgsql
SummitInventory
├── sql/
│   ├── tables.sql        # Schema definitions
│   ├── functions.sql     # Order total function
│   ├── procedures.sql    # Auto restock procedure
│   ├── seed.sql          # Sample data inserts
│   └── test.sql          # End-to-end validation
├── LICENSE               # MIT License
└── README.md             # Project documentation
```

---

## Quick Start

### 1. Create Schema

Run the schema definition script in Oracle Live SQL
 or an Oracle XE instance:

```
@sql/tables.sql
```

### 2. Load Functions and Procedures

```
@sql/functions.sql
@sql/procedures.sql
```

### 3. Insert Sample Data

```
@sql/seed.sql
```

### 4. Execute Tests

Run the validation workflow:

```
@sql/test.sql
```

### Example Output

```
Order 1001 total = 34.50
Order 1002 total = 12.00
Auto restock completed (+10 units per low item).
```


Product records before and after restock demonstrate updated stock quantities and status changes.

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

## Author

Created by Rico Aprilla Nanda
