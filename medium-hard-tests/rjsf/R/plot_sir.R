#' Plot a SIR simulation result
#'
#' @param result A data.frame from jsf_sir() with columns time, S, I, R.
#' @return A ggplot2 object.
#' @export
plot_sir <- function(result) {
  
  long <- tidyr::pivot_longer(result, c(S, I, R), 
                              names_to  = "compartment", 
                              values_to = "count")
  
  ggplot2::ggplot(long, ggplot2::aes(x = time, y = count, colour = compartment)) +
    ggplot2::geom_line(linewidth = 0.8) +
    ggplot2::scale_colour_manual(values = c(S = "steelblue", 
                                            I = "red", 
                                            R = "seagreen")) +
    ggplot2::labs(title   = "SIR Epidemic Model via JSF",
                  x       = "Time", 
                  y       = "Population", 
                  colour  = "Compartment") +
    ggplot2::theme_bw()
}
