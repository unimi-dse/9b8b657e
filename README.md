# SIRDAN  


## about

in this first version, this package provide a function to get criptiocurrencies pairs price data from the Kucoin platform in  a very easy way with the function GetKucoinData()


## usage

you can use this package typing:

devtools::install_github("unimi-dse/9b8b657e")

You can download all criptocurrency pair directly from the Kucoin API, look at the platform to be inspired. Be careful: some pairs are very recent so be sure to use a valid "starting date" parameter.


## getting started with backtest using the sample script

This folder also  provide an example script which shows you how to run a backtest on criptocurrencies data (9b8b657e/inst/).
Before running the sample script make sure to install the following packages (that couldn't be added as a package dependencies)

Blotter
"devtools::install_github("braverock/blotter")"

Quantstrat
"devtools::install_github("braverock/quantstrat")"

the following is the output of the script in (9b8b657e/inst/) which is a simple trend following strategy on ADA/BTC in 1 minute time frame.

![What is this](img/sample1.png)

more about developing YOUR trading strategy at https://www.rdocumentation.org/packages/quantstrat/versions/0.16.6


## prolems

- GetKucoinData: retrieves up to 1500 relevations, way too few in order to have a useful backtest. That's due to the restful API request's constraints.
