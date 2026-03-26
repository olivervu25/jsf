#' Stochastic birth-death simulation using Gillespie algorithm
#'
#' @param N0 Initial population. Default 50.
#' @param lambda Birth rate. Default 0.5.
#' @param mu Death rate. Default 0.3.
#' @param t_max Maximum time. Default 10.
#' @param seed Random seed. Default 42.
#' @return A data.frame with columns time and N.
#' @export
sim_birthdeath_r <- function(N0 = 50, lambda = 0.5, mu = 0.3, 
                             t_max = 10, seed = 42) {
  set.seed(seed)
  t      <- 0
  N      <- N0
  times  <- t
  states <- N
  
  while (t < t_max && N > 0) {
    rate_total <- (lambda + mu) * N
    dt         <- rexp(1, rate_total)
    t          <- t + dt
    if (runif(1) < lambda / (lambda + mu)) {
      N <- N + 1
    } else {
      N <- N - 1
    }
    times  <- c(times, t)
    states <- c(states, N)
  }
  
  data.frame(time = times, N = states, lambda = lambda, mu = mu)
}