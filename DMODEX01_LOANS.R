# Main from xa ----

# Librarys ----
library(tidymodels)
library(ggplot2)
library(tidymodels)

# Parameters ----

# Data
loan_df  <- readRDS("/cloud/project/data/loan_df.rds")

# Describe with Plots
g1 <- ggplot(loan_df, aes(loan_default, ..count.., fill=loan_default))+
  geom_bar()+
  labs(title = "Target proportion in Data")

g2 <- ggplot(loan_df, aes(interest_rate, fill=loan_default))+
  geom_density(alpha= 0.3)

# Train y Test data ----
loan_split <- loan_df %>% initial_split(loan_df, prop = 0.8 ,strata = loan_default)
loan_split

loan_training <- loan_split %>% training()
loan_test <- loan_split %>% testing()

# Specify a logistic regression model ----
logistic_model <- logistic_reg() %>% 
  # Set the engine
  set_engine('glm') %>% 
  # Set the mode
  set_mode('classification')
# Fit to training data
logistic_fit <- logistic_model %>% 
  fit(loan_default ~ . ,
      data = loan_training)
# Print model fit object
# print(logistic_fit)


reportS <- list(data = loan_df , 
                data_train = loan_training, 
                model1 = logistic_fit, 
                g1 = g1, 
                g2 = g2)
