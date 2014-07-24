---
title       : Estimating correlation
subtitle    : Documentation of the Shiny application
author      : 
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]     # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft, selfcontained}
knit        : slidify::knit2slides
github      :
  user  : hohenstein
  repo  : correlation
---

## Correlation

This is the documentation for a Shiny application that demonstrates the 
concept of correlation. The application is online
[here](https://hohenstein.shinyapps.io/correlation/).

<hr>
<br>

The [Pearson correlation coefficient]
(http://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient) 
refers to the linear dependence
between two variables. The correlation coefficient ranges from $-1$ to $1$
where $0$ indicates no correlation. The values of $-1$ and $1$ indicate a
perfect negative and positive relationship, respectively.

<!---
For two random variables, $x$ and $y$, the correlation coefficient $\rho$ of
a population is defined as 
$$\rho = \frac{\mathrm{cov}(x,y)}{\sigma_x \sigma_y},$$
where $\mathrm{cov}(x,y)$ is the [covariance]
(http://en.wikipedia.org/wiki/Covariance) of the two variables. 
Furthermore, $\sigma_x$ and $\sigma_y$ represent the [standard deviations]
(http://en.wikipedia.org/wiki/Standard_deviation) of $x$ and $y$,
respectively. Standard deviation indicates the amount of variation in
a data set.
-->

Note that the correlations can represent linear relationship only. Even if
there is no correlation between two random variables $y$ and $y$, there
might be another type of dependency, for example, a polynomial relationship.

In the **Shiny** application, the slider can be used to choose a correlation 
value. The relationship between the data points displayed in the scatter plot
(first tab) will change accordingly. Try some values and have a look at the 
results.

---

## Illustration

The correlation in a population is indicated by the Greek letter $\rho$.
This can be interpreted as the "true" correlation.

The following figure illustrates different correlation coefficients.
The five panels display scatter plots of $y$ values against $x$ values.
The corresponding correlation coefficients are $-1$, $-0.7$, $0$, $0.7$, and
$1$.

<img src="assets/fig/unnamed-chunk-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" style="display: block; margin: auto;" />

The points in the panels with correlations of $-1$ and $1$ lie on a line.
This is due to the perfect linear relationship between $x$ and $y$.
In contrast, there is no linear relationship when the correlation is $0$.

---

## Distribution of the variables $x$ and $y$

In the **Shiny** application, $x$ and $y$ are represented as a [bivariate
normal distribution]
(http://en.wikipedia.org/wiki/Multivariate_normal_distribution). This is a 
combination of two normal (or Gaussian) distributions. In `R`, the density
of the simple normal distribution is implemented in `dnorm`. You can use the
`curve` function to visualize the distribution.


```r
curve(dnorm(x), -5, 5)
```

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2.png) 

In the bivariate normal distribution, both random variables, $x$ and $y$ 
follow a normal distribution. Additionally, there is a  correlation between
both variables of the population (see the slider in the **Shiny** application). 

---

## Random sampling

We can sample random values of $x$ and $y$ from a population. Due to
the population correlation $\rho$, the realisations of $x$ are not
independent from the realisations of $y$, although sampling is random.

In the **Shiny** application, you can use the numeric input field to specify
the number of random samples. Each random sample is represented by a point
in the scatter plot. Furthermore, the dashed line represents the population
correlation $\rho$ while the solid red line represents the estimated 
correlation, indicated by $r$, in the sample data set.

It turns out that the correlation of the sample data set $r$ 
may differ from $\rho$ due to the randomness. Usually, the absolute 
difference between both values decreases with the number of samples.

This phenomenon is visualized in the plot in the second tab. The red line 
represents how the sample correlation changes with additional samples.

---

## Final remarks

If you want to have a look at the values of the sample data set, you can 
find a table view of $x$ and $y$ in the third tab. Each sample consists
of a pair of two values.

Note that the generation of the second plot may take a while if you
choose a very large number of samples.

A final note on the implementation: In `R`, you can generate random samples
from the bivariate normal distribution with the function `mvrnorm` in the 
`MASS` package. The correlation between two variables $x$ and $y$ can be 
calculated with the `cor` function.


```r
x <- c(0, 2, 4, 6, 2, 5)
y <- c(1, 3, 2, 4, 6, 1)
cor(x, y)
```

```
## [1] 0.05395
```

In the example above, the correlation between vectors `x` and `y` is 
0.05.
