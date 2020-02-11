require(httr)

#THERE IS A CONSTRAINT OF 1500 CANDLES IN THE REQUEST TO THE RESTFUL API...
#A WEBSOKET CONNECTION WILL BE NEEDED...

#provide criptocurrencies pairs data starting on provided datetime at 08:00 AM GMT
#date format yyyymmdd

#Type of candlestick (relevationfrequency) : 1min, 3min, 5min, 15min, 30min, 1hour, 2hour, 4hour, 6hour, 8hour, 12hour, 1day, 1week

#' Retrieve criptocurrencies pairs data from Kucoin API
#'
#' @param criptopair  tag of the desired cripto pair
#'
#' @param relevationfrequency 1min, 3min, 5min, 15min, 30min, 1hour, 2hour, 4hour, 6hour, 8hour, 12hour, 1day, 1week
#'
#' @param startdate YYYY-MM-DD be careful, a lot of criptopairs are very young
#'
#' @param enddate YYYY-MM-DD
#'
#' @return up to 1500 candlestick relevation (very few, must expand this constraint somehow, however that's the first version)
#'         each relevation is composed by open, close, high, low.
#'
#' @export
#'
#' @examples  W = GetKucoinData("ADA-BTC", "1min", "2019-12-31", "2020-01-31")
#'
#'
GetKucoinData <- function(criptopair, relevationfrequency, startdate, enddate ){




baseurl <- 'https://api.kucoin.com'



endpoint <- '/api/v1/market/candles'



da = getnumericdata(startdate)
finoa =  getnumericdata(enddate)


param <- c(symbol = criptopair, type = relevationfrequency, startAt = da, endAt = finoa)


url <- paste0(baseurl, endpoint, '?', paste(names(param), param, sep = '=', collapse = '&'))


x <- GET(url)



x <- content(x)
data <- x$data

data <- sapply(1:length(data), function(i) {


  candle <- as.numeric(data[[i]])


  return( c(time = candle[1], open = candle[2], close = candle[3], high = candle[4], low = candle[5]) )
})



datetime <- as.POSIXct(data[1,], origin = '1970-01-01')
data <- xts(t(data[-1,]), order.by = datetime)


return(data)

}




