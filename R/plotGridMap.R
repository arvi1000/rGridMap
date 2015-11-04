# plotGridMap
#' Plots a filled grid map of US states, represented as hexagons
#'
#' @param x data.frame with data to plot
#' @param state_var name of of column in \code{x} that contains state abbreviations (matching \code{base::state.abb()})
#' @param fill_var column from \code{x} to use for color fill; can be numeric, factor, or character (treated as factor by ggplot)
#' @param alpha_var column from \code{x} to use for fill alpha (NULL by default, for no alpha); can be numeric, factor, or character (treated as factor by ggplot)
#' @param label_var name of column in \code{x} to use for labels; if NULL, then no labels
#' @param label_color_var if NULL, then labels have a fixed color (specified by \code{label_color}). Otherwise, name of column in \code{x} to use for label color scale
#' @param label_color color for label text. Has no effect if you pass a value to \code{label_color_var}
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
#' my_dat <- data.frame(state.abb = c(state.abb, 'DC'),
#'                      value=sample(LETTERS[1:5], 51, replace=T))
#'
#' # note you can manipulate the resultant object as you would any ggplot object
#' my_grid_map +
#'  scale_fill_brewer(type='qual') +
#'  labs(title = 'States by Category', fill = 'Category')

plotGridMap <- function(x,
                        state_var = 'state.abb',
                        fill_var, alpha_var = NULL,
                        label_var = state_var,
                        label_color_var = NULL,
                        label_color = 'black') {

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

  # add labels if called for
  if(!is.null(label_var)) {

    if(is.null(label_color_var)) {
      # if we are assigning a fixed color:
      gg <- gg + ggplot2::geom_text(
        data = subset(plot_dat, order==1),
        aes_string(x = 'lab_x',  y = 'lab_y', label = label_var),
        size = 3, color = label_color)
    } else {

      # if we are mapping color to a scale
      gg <- gg + ggplot2::geom_text(
        data = subset(plot_dat, order==1),
        aes_string(x = 'lab_x',  y = 'lab_y',
                   label = label_var, color = label_color_var),
        size = 3)
    }
  }

  # for categorical data, kill slashes in legend box
  if (class(plot_dat[, fill_var]) %in% c('character', 'factor')) {
    gg <- gg +
    guides(fill = guide_legend(override.aes = list(colour = NULL))) +
    theme(legend.key = element_rect(colour = 'black'))
  }

  return(gg)
}
