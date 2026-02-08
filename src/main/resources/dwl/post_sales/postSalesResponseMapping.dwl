%dw 2.0
output application/json
---
{
	"transactionId": vars.transactionId,
	"message": "Sales transaction created successfully",
	"createdAt": (now() as DateTime) as String { format: "yyyy-MM-dd'T'HH:mm:ss'Z'" }
}