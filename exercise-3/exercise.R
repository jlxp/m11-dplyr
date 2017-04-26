# Exercise 3: Data Frame Practice with `dplyr`.
# Use a different appraoch to accomplish the same tasks as exercise-1


# Install devtools package: allows installations from GitHub
install.packages('devtools')

# Install "fueleconomy" package from GitHub
devtools::install_github("hadley/fueleconomy")

# Require/library the fueleconomy package
# Install (if you haven't already) and load the `dplyr`package
library("fueleconomy")
library("dplyr")
# Which Acura model has the best hwy MPG in 2015? (without method chaining)
acura <- filter(vehicles, make == "Acura", year == 2015)
best.hwy <- filter(acura, hwy == min(hwy))
best.model <- select(best.hwy, model)

# Which Accura model has the best hwy MPG in 2015? (nesting functions)
best.hwy.mpg.2015 <- select(
                        filter(
                          filter(
                            vehicles,
                            make == "Acura",
                            year == 2015), hwy == min(hwy))
                        )

# Which Accura model has the best hwy MPG in 2015? (pipe operator)
best.hwy.mpg.2015.2 <- filter(vehicles, make == "Acura", year == 2015) %>% filter(hwy == min(hwy)) %>% select(model)

### Bonus ###

# Write 3 functions, one for each approach.  Then, 
# Test how long it takes to perform each one 1000 times
WithoutChaining <- function() {
  acura <- filter(vehicles, make == "Acura", year == 2015)
  best.hwy <- filter(acura, hwy == min(hwy))
  best.model <- select(best.hwy, model)
}

Nested <- function() {
  best.hwy.mpg.2015 <- select(
    filter(
      filter(
        vehicles,
        make == "Acura",
        year == 2015), hwy == min(hwy))
  )
}

Pipe <- function() {
  best.hwy.mpg.2015.2 <- filter(vehicles, make == "Acura", year == 2015) %>% filter(hwy == min(hwy)) %>% select(model)
}

system.time(for (i in 1:1000) WithoutChaining())
system.time(for (i in 1:1000) Nested())
system.time(for (i in 1:1000) Pipe())