library(rGridMap)
library(ggplot2)

# a data.frame of states with random categorical value
my_dat <- data.frame(state.abb, value=sample(LETTERS[1:5], 50, replace=T))

# build grid map plot
my_grid_map <- plotGridMap(my_dat, fill_var = 'value', label_var = 'state.abb')

# and you can manipulate the resultant object as you would any ggplot object
my_grid_map +
  scale_fill_brewer(type='qual') +
  labs(title = 'States by Category', fill = 'Category') +
  annotate(geom='text', size = 3, color='grey25',
           label='made in R with github.com/arvi1000/rGridMap',
           x=median(my_grid_map$layers[[1]]$data$draw_x), y=-3)


ggsave('example/rGridMap_example.svg', width=8, height=6)
