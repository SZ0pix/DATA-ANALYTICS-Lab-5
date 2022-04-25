data{
    int<lower=1> N; //number of observations
    int<lower=1> M; //number of covariates
    matrix[N,M] X;  //covariates matrix design
    int<lower=0, upper=1> y[N]; //binary variates
}

transformed data {
   vector[N] ones_N = rep_vector(1,N);
}

parameters{
    vector[M] beta; //slopes
    real alpha;     //intercept
}

model{
    beta ~ normal(0, 0.75);     //prior model
    alpha ~ normal(0, 0.75);    //prior model
    y ~ bernoulli_logit(X*beta+alpha); //observational model
}

//simulate empirical probabilities from th ecurrent value of the parameters

generated quantities {
   int y_ppc[N] = bernoulli_logit_rng(X*beta+ones_N*alpha);
   vector[N] prob_ppc = inv_logit(X*beta+ones_N*alpha);
}
