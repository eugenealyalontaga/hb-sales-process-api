%dw 2.0
import * from dw::core::Binaries
output application/json
var salesSql = "INSERT INTO sales (" ++ "transaction_id, source, customer_name, delivery_address, customer_contact, " ++ "customer_age, customer_gender, total_amount, payment_type, transaction_date" ++ ") VALUES (" ++ "'" ++ ((payload.sales.transactionId default "") replace "'" with "''") ++ "'," ++ "'" ++ ((payload.sales.source default "") replace "'" with "''") ++ "'," ++ "'" ++ ((payload.sales.customerName default "") replace "'" with "''") ++ "'," ++ "'" ++ ((payload.sales.deliveryAddress default "") replace "'" with "''") ++ "'," ++ "'" ++ ((payload.sales.customerContact default "") replace "'" with "''") ++ "'," ++ (payload.sales.customerAge default null) ++ "," ++ (if ( payload.sales.customerGender == null ) "NULL"
else
  "'" ++ ((payload.sales.customerGender default "") replace "'" with "''") ++ "'") ++ "," ++ (payload.sales.totalAmount default 0) ++ "," ++ "'" ++ ((payload.sales.paymentType default "") replace "'" with "''") ++ "'," ++ (if ( payload.sales.transactionDate == null ) "CURRENT_TIMESTAMP"
else
  "TIMESTAMP '" ++ ((payload.sales.transactionDate replace "T" with " ") replace "Z" with "") ++ "'") ++ ");"
var itemsSql = (payload.salesItems default []) map (i) -> "INSERT INTO sales_items (item_id, transaction_id, product_name, price, quantity) VALUES (" ++ "'" ++ ((i.itemId default "") replace "'" with "''") ++ "'," ++ "'" ++ ((payload.sales.transactionId default "") replace "'" with "''") ++ "'," ++ "'" ++ ((i.productName default "") replace "'" with "''") ++ "'," ++ (i.price default 0) ++ "," ++ (i.quantity default 0) ++ ");"
var sqlScript = salesSql ++ "\n\n" ++ (itemsSql joinBy "\n")
---
{
	operation: "INSERT",
	query: toBase64(sqlScript)
}