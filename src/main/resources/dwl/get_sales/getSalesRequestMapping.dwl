%dw 2.0
import * from dw::core::Binaries
var txId = ((vars.transactionId default "") as String) replace "'" with "''"
var sql = "SELECT " ++ "  s.transaction_id," ++ "  s.source," ++ "  s.customer_name," ++ "  s.delivery_address," ++ "  s.customer_age," ++ "  s.customer_gender," ++ "  s.customer_contact," ++ "  s.total_amount," ++ "  s.payment_type," ++ "  s.transaction_date," ++ "  si.item_id," ++ "  si.product_name," ++ "  si.price," ++ "  si.quantity " ++ "FROM sales s " ++ "LEFT JOIN sales_items si ON si.transaction_id = s.transaction_id " ++ "WHERE s.transaction_id = '" ++ txId ++ "' " ++ "ORDER BY si.item_id;"
output application/json
---
{
	operation: "SELECT",
	query: toBase64(sql)
}