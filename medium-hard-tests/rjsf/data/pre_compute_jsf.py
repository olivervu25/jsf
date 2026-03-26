import jsf
import random
import pandas as pd

# Run birth-death for multiple lambda/mu combinations
params = [
    (0.5, 0.3),
    (0.3, 0.5),
    (0.5, 0.5),
    (0.8, 0.3),
]

results = []

for lam, mu in params:
    random.seed(42)
    
    x0    = [50]
    rates = lambda x, t, l=lam, m=mu: [l * x[0], m * x[0]]
    
    reactant = [[1], [1]]
    product  = [[2], [0]]
    
    stoich = {
        "nu":         [[1], [-1]],
        "DoDisc":     [1],
        "nuReactant": reactant,
        "nuProduct":  product,
    }
    
    opts = {
        "EnforceDo":          [0],
        "dt":                 0.01,
        "SwitchingThreshold": [20],
    }
    
    sim = jsf.jsf(x0, rates, stoich, t_max=10, config=opts, method="operator-splitting")
    
    df = pd.DataFrame({
        "time":   sim[1],
        "N":      sim[0][0],
        "lambda": lam,
        "mu":     mu
    })
    results.append(df)

pd.concat(results).to_csv("jsf_birthdeath.csv", index=False)
print("Done!")