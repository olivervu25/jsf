# rjsf

An R wrapper for the Python [`jsf`](https://github.com/DGermano8/jsf) package by Germano et al. (2024), providing R bindings via `reticulate` for simulating compartmental models using the Jump-Switch-Flow algorithm.

## Installation
```r
devtools::install_github("vuthanh25aus/rjsf")
```

## Usage

### SIR Epidemic Model
```r
library(rjsf)

result <- jsf_sir(N = 1000, I0 = 10, beta = 0.5, gamma = 0.1, t_max = 60)
plot_sir(result)
```

### Birth-Death Process: Gillespie (R) vs JSF (Python)
```r
# Run R stochastic simulation
sim_r <- sim_birthdeath_r(N0 = 50, lambda = 0.5, mu = 0.3, t_max = 10)

# Compare across multiple (lambda, mu) combinations
plot_birthdeath_comparison()
```

## Requirements

- R >= 4.0
- Python >= 3.9 with the [`jsf`](https://github.com/DGermano8/jsf) package installed
- `reticulate`, `ggplot2`, `tidyr`

## Tests

- **Medium test:** R package wrapping Python `jsf` via `reticulate` — SIR epidemic model
- **Hard test:** Stochastic birth-death simulation in R (Gillespie) compared to pre-computed JSF output across different growth and death rates