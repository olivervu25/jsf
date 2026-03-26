#' Run a SIR epidemic simulation using JSF
#'
#' @param N Total population size. Default 1000.
#' @param I0 Initial number of infected. Default 10.
#' @param beta Transmission rate. Default 0.5.
#' @param gamma Recovery rate. Default 0.1.
#' @param t_max Maximum simulation time. Default 60.
#' @param seed Random seed. Default 42.
#' @return A data.frame with columns time, S, I, R.
#' @export
jsf_sir <- function(N = 1000, I0 = 10, beta = 0.5, gamma = 0.1,
                    t_max = 60, seed = 42) {
  
  reticulate::py_run_string(paste0("import random; random.seed(", seed, ")"))
  jsf <- reticulate::import("jsf")
  
  x0 <- list(as.numeric(N - I0), as.numeric(I0), 0.0)
  
  rates <- reticulate::py_eval(
    paste0("lambda x, t: [", beta, "*x[0]*x[1]/", N, ", ", gamma, "*x[1]]")
  )
  
  reactant <- list(list(1,1,0), list(0,1,0))
  product  <- list(list(0,2,0), list(0,0,1))
  
  stoich <- list(
    nu         = list(list(-1,1,0), list(0,-1,1)),
    DoDisc     = list(0L, 1L, 0L),
    nuReactant = reactant,
    nuProduct  = product
  )
  
  opts <- list(
    EnforceDo          = list(0L, 0L, 0L),
    dt                 = 0.1,
    SwitchingThreshold = list(as.numeric(N), 10.0, as.numeric(N))
  )
  
  sim <- jsf$jsf(x0, rates, stoich, t_max, config = opts,
                 method = "operator-splitting")
  
  data.frame(
    time = unlist(sim[[2]]),
    S    = unlist(sim[[1]][[1]]),
    I    = unlist(sim[[1]][[2]]),
    R    = unlist(sim[[1]][[3]])
  )
}