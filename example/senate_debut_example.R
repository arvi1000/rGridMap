# If necessary:
# library(devtools)
# install_github('arvi1000/rGridMap')

library(rGridMap)
library(rvest)
library(lubridate)
library(data.table)
library(ggplot2)

## PART ONE: Organize data ----

# scrape wiki table on US senators
url <- 'https://en.wikipedia.org/wiki/List_of_current_United_States_Senators'
wiki_page <- html(url)
wiki_table <-
  wiki_page %>% html_nodes('table') %>% .[[6]] %>% html_table()

# clean up names
names(wiki_table) <-
  names(wiki_table) %>% gsub('\\s|/', '_', .) %>% tolower

# get two letter abbrevations from state.name
setDT(wiki_table)
wiki_table[, state.abb := state.abb[match(state, state.name)]]

# data frame of year senior senator began term, by state
plot_dat <-
  wiki_table[, .(began= min(year(mdy(assumed_office)))), by=state.abb]

# make a label column
plot_dat[, label:=paste0(state.abb, '\n', began)]
plot_dat[, began_fac := cut(began,
                            breaks = seq(1970, 2020, 10),
                            labels = paste0(seq(1970, 2010, 10), 's'))]

## PART TWO: Make grid map ----

# build
senate_debut_gg <-
  plotGridMap(plot_dat, fill_var = 'began_fac', label_var = 'label') +
    scale_fill_brewer(palette = 4) +
    labs(title ='Term Debut of Senior Senator, by State', fill = 'Decade')

# print
senate_debut_gg

# optional, save to file:
ggsave('rGridMap/example/senate_debut.png', senate_debut_gg, width = 8, height = 6)

