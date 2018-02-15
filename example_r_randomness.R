require(dplyr)
set.seed(1)
sample_size <- 10

# simple illustration of random draws
normal_draws <-  rnorm(sample_size, mean=0, sd=1)
mean(normal_draws)
hist(normal_draws)

# what's the distribution of the mean meausrements as we do this over and over?
list_of_means <- array()
times_to_loop <- 100000

for (i in 1:times_to_loop){
  normal_draws <-  rnorm(sample_size, mean=0, sd=1)
  list_of_means[i] <- mean(normal_draws)
}

hist(list_of_means)

d <- density(list_of_means) # returns the density data 
plot(d) # plots the results
mean(list_of_means)
sd(list_of_means)


## let's play with a regression now
draws <- 1000
set.seed(2)

# create a DF with 3 columns, 1000 rows of random standard normal draws
random_regression <- data.frame(replicate(3,rnorm(draws)))

#calculate the dependent variable Y
random_regression %>% mutate(
    e = rnorm(draws, 0, 1), ## better add some error noise
    Y = 2 * X1 + 3 * X2 + 4 * X3 + e
) -> random_regression

# build a linear regression
model <- lm( Y ~ X1 + X2 + X3, data=random_regression )
summary(model)
