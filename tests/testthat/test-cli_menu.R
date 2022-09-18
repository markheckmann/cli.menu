


test_that("collect_integers() yields correct results", {
  v <- c("1 2 3", "1,2,3", "1; 2 ,3;", "A1 DD;- 2 3", "3  2 -1", "3  :  1") # all yield 1:3
  res <- lapply(v, collect_integers)
  expect_true(all(sapply(res, all.equal, 1:3)))
})
