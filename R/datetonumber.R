#' auxiliary function to allow getkucoindata to work
#'
#' @param date to translate in number
#'
#' @return
#' @export
#'
#' @examples
getnumericdata <- function(date){

daytimestring = paste0(date, "08:00:00", "GMT")

posixctdate = as.POSIXct(daytimestring)

numberdate = as.integer(as.numeric(posixctdate))

return(numberdate)

}



