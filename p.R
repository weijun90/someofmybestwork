#question 1 & 2 
log_mean = -4.98
log_stdev = 0.95
safe_level = 0.01
n = 30
x_stdev = 0.14
observed_mean = 0.047

#log_mean = -2.12 
#log_stdev = 1.34 
#safe_level = 0.09
#n = 30
#x_stdev = 0.028 
#observed_mean = 0.052 

eps = 0.1

num_ho = 0;
num_theta = 0;
num_ho_data = 0;
num_ho_1 = 0;

num_h1_data = 0;
theta_data = 0;

bayes_factor = 0;
p_ho = 0;
p_h1 = 0;
little_intervel1 = 0;
little_intervel2 = 0;
p_data_ho = 0;
pr_data_h1 = 0;

little_intervel1 = observed_mean * (1 - eps);
little_intervel2 = observed_mean * (1 + eps);

x = vector()
theta = rlnorm(20000,log_mean, log_stdev)


for (i in 1:length(theta)) {
  if (theta[i] <= safe_level) {
    num_ho = num_ho + 1
  }
  num_theta = num_theta + 1
  x[i] = rnorm(1,theta[i],x_stdev/sqrt(n))
  if (x[i]>little_intervel1 && x[i] < little_intervel2) { 
    theta_data = theta_data + 1
    if (theta[i] <= safe_level){
      num_ho_data = num_ho_data + 1
    }    
  }
}

p_ho = num_ho/num_theta
p_h1 = 1 - p_ho;

prior_odds = p_ho/p_h1;

p_data_ho = num_ho_data / num_ho;
num_ho_1 = num_theta - num_ho;
num_h1_data = theta_data - num_ho_data;
pr_data_h1 = num_h1_data/num_ho_1;

bayes_factor = p_data_ho/pr_data_h1
Posterior_odds = prior_odds*bayes_factor


