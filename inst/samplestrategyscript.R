
W = GetKucoinData("ADA-BTC", "1min", "2019-12-31", "2020-01-31")


closingprice = W[,2]   #we will trade on the candle's closing price

stock.str='ADABTC'

currency('USD')  #to do, modify the possibility to add other currencies (eg criptocurrencies)
stock(stock.str,currency="USD",multiplier=1)


#SET THE BACKTEST PROPERTIES:
PORTFOLIOID = "16"
startDate="2018-01-01"
initEq=1000000



portfolio.st=PORTFOLIOID
account.st=PORTFOLIOID
initPortf(portfolio.st,symbols=stock.str)
initAcct(account.st,portfolios=portfolio.st, initEq=initEq)
initOrders(portfolio=portfolio.st)



#STRATEGY DEFINITION:
stratMACROSS<- strategy(portfolio.st) #l'oggetto (funzione) strategy fa parte di quantstrat

stratMACROSS <- add.indicator(strategy = stratMACROSS, name = "SMA", arguments = list(x=quote(closingprice), n=50),label= "ma50" )
stratMACROSS <- add.indicator(strategy = stratMACROSS, name = "SMA", arguments = list(x=quote(closingprice), n=200),label= "ma200")

stratMACROSS <- add.signal(strategy = stratMACROSS,name="sigCrossover",arguments = list(columns=c("ma50","ma200"), relationship="gte"),label="ma50.gt.ma200")
stratMACROSS <- add.signal(strategy = stratMACROSS,name="sigCrossover",arguments = list(column=c("ma50","ma200"),relationship="lt"),label="ma50.lt.ma200")

stratMACROSS <- add.rule(strategy = stratMACROSS,name='ruleSignal', arguments = list(sigcol="ma50.gt.ma200",sigval=TRUE, orderqty=100, ordertype='market', orderside='long'),type='enter')
stratMACROSS <- add.rule(strategy = stratMACROSS,name='ruleSignal', arguments = list(sigcol="ma50.lt.ma200",sigval=TRUE, orderqty='all', ordertype='market', orderside='long'),type='exit')



ADABTC = closingprice
start_t<-Sys.time()


#RUNNING THE BACKTEST:
out<-applyStrategy(strategy=stratMACROSS , portfolios=portfolio.st)

end_t<-Sys.time()
print(end_t-start_t)



start_t<-Sys.time()
updatePortf(Portfolio=PORTFOLIOID,Dates=paste('::',as.Date(Sys.time()),sep=''))

end_t<-Sys.time()
print("trade blotter portfolio update:")

print(end_t-start_t)

#PLOT THE BACKTEST RESULTS
chart.Posn(Portfolio=PORTFOLIOID,Symbol=stock.str, TA=c("add_SMA(n=50,col='red')","add_SMA(n=200,col='blue')"))



