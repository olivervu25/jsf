# rjsf

An R wrapper for the Python [`jsf`](https://github.com/DGermano8/jsf) package by Germano et al. (2024), providing R bindings via `reticulate` for simulating compartmental models using the Jump-Switch-Flow algorithm.

## Installation
```r
devtools::install_github("oliver-vu/rjsf")
```

## Usage
```r
library(rjsf)

# Run a SIR epidemic simulation
result <- jsf_sir(N = 1000, I0 = 10, beta = 0.5, gamma = 0.1, t_max = 60)

# Plot the result
plot_sir(result)
```

## Requirements

- R >= 4.0
- Python >= 3.9 with the [`jsf`](https://github.com/DGermano8/jsf) package installed
- `reticulate`, `ggplot2`, `tidyr`