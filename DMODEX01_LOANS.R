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

# Predict outcome categories
class_preds <- predict(logistic_fit, new_data = loan_test,
                       type = 'class')

# Obtain estimated probabilities for each outcome value
prob_preds <- predict(logistic_fit, new_data = loan_test, 
                      type = 'prob')

class_preds <- loan_test %>% 
     select(loan_default) %>% 
     bind_cols(class_preds, prob_preds)
  
# Combine test set results
# telecom_results <- telecom_test %>% 
#   select(canceled_service) %>% 
#   bind_cols(class_preds, prob_preds)
# # View results tibble
# telecom_results



reportS <- list(data = as.data.frame(loan_df) , 
                data_train = loan_training, 
                model1 = logistic_fit, 
                model1_predc = class_preds,
                g1 = g1, 
                g2 = g2)
