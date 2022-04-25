data{
    int<lower=1> N; //number of observations
    int<lower=1> M; //number of covariates
    matrix[N,M] X;  //covariates matrix design
    real sigma;     //prior standard deviation
}

transformed data {
   vector[N] ones_N = rep_vector(1,N);
   vector[M] ones_M = rep_vector(1,M);

}

//simulate empirical probabilistoc from the curret value of the parameters

generated quantities {
    vector[N] prob_ppc;
    real beta[M] = normal_rng(0, ones_M*sigma); //prior model
    real alpha = normal_rng(0, sigma); //prior model
    prob_ppc = inv_logit(X*to_vector(beta)+ones_N*alpha);
}
