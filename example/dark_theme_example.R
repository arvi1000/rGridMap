# if necessary, install the package:
# devtools::install_github('arvi1000/rGridMap')
library(rGridMap)
library(ggplot2)

# a data.frame of states with random categorical value
set.seed(123)
my_dat <- data.frame(state.abb = c(state.abb, 'DC'), # don't forget DC!
                     value=runif(51))

plotGridMap(my_dat, fill_var = 'value',
            # this turns labels white
            label_color = 'white') +
  scale_fill_viridis_c(option = 'A') +
  labs(title = 'States with Random Value', fill = 'Some Value',
       subtitle = 'black background, white state labels') +
  # this is to make background black
  theme(rect = element_rect(fill='black'),
        text = element_text(color='white'),
        legend.key= element_blank())
