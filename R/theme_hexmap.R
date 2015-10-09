# theme_hexmap
# ' Internal function that returns a ggplot theme with most stuff removed

theme_hexmap <- function() {
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank())
}
