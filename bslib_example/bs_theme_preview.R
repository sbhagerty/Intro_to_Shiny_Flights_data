library(thematic)
library(bslib)
library(nycflights13)

bs_theme_preview(shannons_theme)
bs_theme_preview(material)
run_with_themer('bslib_example')

#Bonus thematic content
thematic_on()
flights %>% filter(origin == 'EWR', carrier=='US') %>% 
ggplot()+ geom_smooth(aes(x=month, y= dep_delay))+
  xlab('Month')+
  ylab('Departure Delay (minutes)')
thematic_off()
