%dw 2.0
output application/json
var person = payload
var xmlData = "<person xmlsns='http://example.com'><name surname='Doe'>John</name><age>30</age></person>"
---
{
// Single-value Selector
"name": person.name,
// Multi-value Selector
"phones": flatten(person.*phones)."type",
// Descendants Selector
"city": person..city,
// Dynamic Selector
"dynamicName": person ["name"],
// Key-value Pair Selector
"address": person.&address,
// Index Selector
"firstPhone": person.phones [0],
// Range Selector
"phoneRange": person.phones [0 to -1],
// XML Attribute Selector
"xmlName": read(xmlData,"application/xml").person.name.@surname,
// Namespace Selector
"xmlNamespace": read(xmlData,"application/xml").person.#,
// Key Present Selector
"hasPhone": person.phones?,
// Assert Present Selector
"assertName": person.name!,
// Filter Selector
"filterPhones": person.phones[?($."type" == "mobile")],
// Metadata Selector
//"metadata": ^.mimeType, //works when we have the metadata set.
}

/*
DataWeave selectors :

1. Single-Value Selector (.keyName)
This selector allows you to access a single value from an object or array by its key.

2. Multi-Value Selector (.*keyName)
Retrieve all values of a matching key across objects or arrays.

3. Descendants Selector (..keyName)
Access matching keys at any depth within a nested structure, making it ideal for working with deeply nested data.

4. Dynamic Selector ([keyName])
Use a variable key to dynamically access values, providing more flexibility in how data is handled.

5. Key-Value Pair Selector (&keyName)
Extract the entire object associated with a specific key, allowing you to work with the full structure.

6. Index Selector ([<index>])
Select elements from an array using their index. Negative indexes can be used to reference elements from the end of an array.

7. Range Selector ([<start> to <end>])
Select a range of elements from an array, enabling you to pull subsets of data easily.

8. XML Attribute Selector (.@attributeName)
Access attributes from XML data, letting you retrieve metadata or specific attributes without parsing the entire XML structure.

9. Namespace Selector (.#)
Retrieve the namespace associated with a key in XML, useful for working with XML documents that use namespaces.

10. Key Present Selector (keyName?)
Check if a key exists in an object or array. This is useful for conditional logic or ensuring that a key is present before proceeding.

11. Assert Present Selector (keyName!)
Ensure that a key is present in the data. If the key is absent, an exception is thrown, providing an easy way to enforce key existence.

12. Filter Selector ([?(expression)])
Filter elements based on a boolean expression. This allows you to easily filter arrays or objects according to dynamic conditions.

13. Metadata Selector (^.metadataKey)
Access metadata associated with the payload, such as MIME type, encoding, or custom metadata. This is essential for dealing with additional information that comes with data.
*/