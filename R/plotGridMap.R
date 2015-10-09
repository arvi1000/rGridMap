# plotGridMap
#' Plots a filled grid map of US states, represented as hexagons
#'
#' @param x data.frame with data to plot
#' @param fill_var column from \code{x} to use for color fill; can be numeric, factor, or character (treated as factor by ggplot)
#' @param state_var name of of column in \code{x} that contains state abbreviations (matching \code{base::state.abb()})
#' @param label_var name of of column in \code{x} to use for labels; if NULL, then no labels
#' @param label_color color for label text
#'
#' @import ggplot2
#'
#' @export
#'
#' @return Returns a ggplot
#'
#' @examples
#' # a data.frame of states with random categorical value
#' my_dat <- data.frame(state.abb, value=sample(LETTERS[1:5], 50, replace=T))
#'
#' # build grid map plot
#' my_grid_map <- plotGridMap(my_dat, fill_var = 'value', label_var = 'state.abb')
#'
#' # note you can manipulate the resultant object as you would any ggplot object
#' my_grid_map +
#'  scale_fill_brewer(type='qual') +
#'  labs(title = 'States by Category', fill = 'Category')

plotGridMap <- function(x,
                        fill_var, state_var = 'state.abb',
                        label_var = NULL, label_color = 'black') {

  plot_dat <-
    merge.data.frame(x, getStateHexPoly(state_col = state_var), by = state_var)

  gg <-
    ggplot2::ggplot() +
    ggplot2::geom_polygon(data = plot_dat,
                 aes_string(x='draw_x', y='draw_y',
                            group=state_var, order='order', fill=fill_var),
                 color='black') +
    ggplot2::coord_fixed() +
    theme_hexmap()

  if(!is.null(label_var)) {
    gg <- gg + ggplot2::geom_text(
      data = subset(plot_dat, order==1),
      aes_string(x = 'lab_x',  y = 'lab_y', label = label_var),
      size = 3, color = label_color)
  }

  # for categorical data, kill slashes in legend box
  if (class(plot_dat[, fill_var]) %in% c('character', 'factor')) {
    gg <- gg +
    guides(fill = guide_legend(override.aes = list(colour = NULL))) +
    theme(legend.key = element_rect(colour = 'black'))
  }

  return(gg)
}
