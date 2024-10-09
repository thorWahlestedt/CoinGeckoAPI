
get_crypto_price <- function(coin_id = "bitcoin", vs_currency = "usd") {
  url <- paste0("https://api.coingecko.com/api/v3/simple/price?ids=", coin_id, "&vs_currencies=", vs_currency)
  response <- httr::GET(url)
  if (httr::status_code(response) == 200) {
    return(jsonlite::fromJSON(httr::content(response, as = "text")))
  }
  else {
    stop("API request failed with status code ", httr::status_code(response))
  }
}

get_historical_data <- function(coin_id = "bitcoin", days = 30, vs_currency = "usd") {
  url <- paste0("https://api.coingecko.com/api/v3/coins/", coin_id, "/market_chart?vs_currency=", vs_currency, "&days=", days)
  response <- httr::GET(url)
  if (httr::status_code(response) == 200) {
    return(jsonlite::fromJSON(httr::content(response, as = "text")))
  }
  else {
    stop("API request failed with status code ", httr::status_code(response))
  }
}

get_supported_coins <- function() {
  url <- "https://api.coingecko.com/api/v3/coins/list"
  response <- httr::GET(url)

  if (httr::status_code(response) == 200) {
    return(jsonlite::fromJSON(httr::content(response, as = "text")))
  }
  else {
    stop("API request failed with status code ", httr::status_code(response))
  }
}

get_coin_market_data <- function(coin_id = "bitcoin", vs_currency = "usd") {
  url <- paste0("https://api.coingecko.com/api/v3/coins/markets?vs_currency=", vs_currency, "&ids=", coin_id)
  response <- httr::GET(url)

  if (httr::status_code(response) == 200) {
    return(jsonlite::fromJSON(httr::content(response, as = "text")))
  }
  else {
    stop("API request failed with status code ", httr::status_code(response))
  }
}

coins <- get_supported_coins()
head(coins, 10)  # View the first 10 coins
bitcoin_price <- get_crypto_price("bitcoin", "usd")
print(bitcoin_price) # Get price of bitcoin in USD
market_data <- get_coin_market_data("bitcoin", "usd")
market_data
historicals <- get_historical_data("bitcoin", 30, "usd")
print(historicals)

