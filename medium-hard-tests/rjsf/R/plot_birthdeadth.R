#' Compare R stochastic simulation vs JSF birth-death process
#'
#' @param N0 Initial population.
#' @param t_max Maximum time.
#' @return A ggplot2 object.
#' @export
plot_birthdeath_comparison <- function(N0 = 50, t_max = 10) {
  
  # Load pre-computed JSF output
  jsf_data <- read.csv(system.file("data/jsf_birthdeath.csv", package = "rjsf"))
  
  # Run R Gillespie for same lambda/mu combinations
  params <- list(
    c(0.5, 0.3),
    c(0.3, 0.5),
    c(0.5, 0.5),
    c(0.8, 0.3)
  )
  
  r_sims <- do.call(rbind, lapply(params, function(p) {
    sim_birthdeath_r(N0 = N0, lambda = p[1], mu = p[2], t_max = t_max)
  }))
  
  # Add method label
  r_sims$method   <- "Gillespie (R)"
  jsf_data$method <- "JSF (Python)"
  
  # Combine
  combined <- rbind(r_sims, jsf_data)
  combined$label <- paste0("λ=", combined$lambda, ", μ=", combined$mu)
  
  ggplot2::ggplot(combined, ggplot2::aes(x = time, y = N, 
                                         colour = method)) +
    ggplot2::geom_line(linewidth = 0.7, alpha = 0.8) +
    ggplot2::facet_wrap(~ label, scales = "free_y") +
    ggplot2::scale_colour_manual(values = c("Gillespie (R)" = "steelblue",
                                            "JSF (Python)"  = "red")) +
    ggplot2::labs(
      title   = "Birth-Death Process: Gillespie vs JSF",
      x       = "Time",
      y       = "Population N(t)",
      colour  = "Method",
      caption = "Each panel shows a different (λ, μ) combination"
    ) +
    ggplot2::theme_bw() +
    ggplot2::theme(legend.position = "bottom")
}