# theme_hexmap
# ' Internal function that returns a ggplot theme with most stuff removed

theme_hexmap <- function() {
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank(),
        
        # need this so legend key still has boxes, after we nix the slashes
        legend.key = element_rect(colour = 'black'))
}
