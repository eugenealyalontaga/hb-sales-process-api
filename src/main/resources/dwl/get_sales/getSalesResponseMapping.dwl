%dw 2.0
var records = payload.data
var header = records[0]
output application/json  skipNullOn = "everywhere"
---
if ( isEmpty(records) ) {
	message: "No data found"
}
else
  {
	transactionId: header.transaction_id,
	source: header.source,
	customerName: header.customer_name,
	deliveryAddress: header.delivery_address,
	customerAge: header.customer_age,
	customerGender: header.customer_gender,
	customerContact: header.customer_contact,
	items: records map (item) -> {
		itemId: item.item_id,
		name: item.product_name,
		price: item.price,
		quantity: item.quantity
	},
	totalAmount: header.total_amount,
	paymentType: header.payment_type,
	transactionDate: (header.transaction_date as DateTime) as String {
		format: "yyyy-MM-dd'T'HH:mm:ss'Z'"
	}
}