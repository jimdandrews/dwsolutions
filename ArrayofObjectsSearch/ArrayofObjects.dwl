%dw 2.0

import * from dw::core::Arrays

output application/json
var searchType = "BUY"
var searchTicker = "AMZN"
---


    (payload map (value, index) -> 
    value mapObject ( 
        read($.message,'application/json')
    )
    ) countBy ($.tradeType == searchType and $.tickerSymbol == searchTicker)
