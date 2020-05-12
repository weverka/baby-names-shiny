# baby-names-shiny
This was an attempt to use the R package Shiny to create an interactive tool that allows users to explore the relative popularity of names over time. This uses data from the package ['babynames'] (https://cran.r-project.org/web/packages/babynames/index.html), which I believe is originally derived from the [US Social Security Administration] (https://www.ssa.gov/oact/babynames/limits.html) data.

The structure of the code is a) the creation of the user interface and b) the actions to be performed by the server. The data are visualized using the ggplot library. The first name choices are generated server-side when the user starts typing as loading all 97,000+ name choices into the client browser caused significant performance delay.
