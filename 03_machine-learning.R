# scripts/03_machine-learning.R
library(tidymodels)
library(themis)

dat <- read_csv("data/clean/violations_labeled.csv")

set.seed(123)
n_pos <- nrow(dat)
fake_neg <- dat %>%
  sample_n(size = n_pos * 2, replace = FALSE) %>%
  mutate(any_violation = 0)

full_dat <- bind_rows(dat, fake_neg) %>% mutate(any_violation = factor(any_violation))

split <- initial_split(full_dat, prop = 0.8, strata = any_violation)
train <- training(split)
test  <- testing(split)

rec <- recipe(any_violation ~ med_income + poverty_rate + pct_renter + age, data = train) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_smote(any_violation)

rf_spec <- rand_forest(mtry = 3, trees = 500) %>%
  set_engine("ranger") %>%
  set_mode("classification")

wf <- workflow() %>% add_recipe(rec) %>% add_model(rf_spec)
fit <- fit(wf, data = train)

pred <- predict(fit, test, type = "prob") %>% bind_cols(test)
roc_auc_est <- roc_auc(pred, truth = any_violation, .pred_1)

saveRDS(fit, "data/clean/rf_model.rds")
saveRDS(roc_auc_est, "data/clean/roc_auc.rds")