
test_that("get_historical_data returns valid structure", {
  # Test for Bitcoin over the last 30 days in USD
  result <- get_historical_data("bitcoin", 30, "usd")

  # Check if result is a list
  expect_type(result, "list")

  # The result should have time-series data for prices, market_caps, and total_volumes
  expect_true("prices" %in% names(result))
  expect_true("market_caps" %in% names(result))
  expect_true("total_volumes" %in% names(result))

  # Ensure prices have at least one entry
  expect_true(length(result$prices) > 0)
})

test_that("get_historical_data handles invalid coin ID", {
  # Test for an invalid coin ID (should throw an error)
  expect_error(get_historical_data("invalidCoin", 30, "usd"))
})

test_that("get_historical_data handles extreme values for days", {
  # Test for 1 day of data
  result_1_day <- get_historical_data("bitcoin", 1, "usd")
  expect_true(length(result_1_day$prices) > 0)

  # Test for max days (CoinGecko API may have limits)
  result_max_days <- get_historical_data("bitcoin", 1000, "usd")
  expect_true(length(result_max_days$prices) > 0)
})

test_that("get_supported_coins returns valid structure", {
  result <- get_supported_coins()
  expect_true("id" %in% colnames(result))
  expect_true("symbol" %in% colnames(result))
})

test_that("get_coin_market_data returns valid market data", {
  result <- get_coin_market_data("bitcoin", "usd")
  expect_true(is.list(result))
  expect_true("market_cap" %in% names(result[[1]]))
})

