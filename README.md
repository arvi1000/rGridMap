# rGridMap
An R Package for tessellated hexagon grid maps of US states in R + ggplot2

Inspired by the [blog post](http://blog.apps.npr.org/2015/05/11/hex-tile-maps.html) by Danny DeBelius of the NPR visuals team and the tweet storm and Flowing Data covereage that followed.

It is easy to use!

    # a data.frame of states with random categorical value
    my_dat <- data.frame(state.abb, value=sample(LETTERS[1:5], 50, replace=T))

    # build grid map plot
    my_grid_map <- plotGridMap(my_dat, fill_var = 'value', label_var = 'state.abb')

    # and you can manipulate the resultant object as you would any ggplot object
    my_grid_map +
     scale_fill_brewer(type='qual') +
     labs(title = 'States by Category', fill = 'Category')


![](https://raw.github.com/arvi1000/rGridMap/master/example/rGridMap_example.svg)
