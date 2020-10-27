# Coding exercises for Data Visualization
# GSfBS, Köln
# Rick Scavetta
# 27.10.2020
# Notes from the second 2-hour group session

# Using color ----
# Colors can be defined using hex code
myRed <- "#e41a1c" #RRGGBB

# Hexidecimal (base 16): 0-9a-f
# 1-digit: 16 (16^1) 0-9a-f
# 2-digit: 256 (16^2) 00-ff

# Decimal (base 10): 0-9
# 1-digit: 10  (10^1) 0-9
# 2-digit: 100 (10^2) 00-99

# What color is this:
"#000000" # No color - Black
"#FF0000" # Pure red
"#FFFFFF" # All color - White

munsell::plot_hex("#FFFFFF")

# 16 777 216 color combinations
256^3

library(RColorBrewer)
display.brewer.all()
display.brewer.pal(3, "Dark2")

display.brewer.pal(9, "Blues")
brewer.pal(9, "Blues")

# Just get the 4th, 6th and the 8th blue color:
myBlues <- brewer.pal(9, "Blues")[c(4,6,8)]

# Coding challenges:
# Data
iris

# load the package
library(ggplot2)

# 1 - Make base layer (data & aesthetics)
# Sepal Width vs Sepal Length (Y vs X, Y ~ X)
# Colored according to Species
g <- ggplot(iris, aes(x = Sepal.Length, 
                      y = Sepal.Width, 
                      color = Species))


# 2 - Add the geometries layer
# Create basic scatter plot
# This it mostly perfectly fine, but it doesn't 
# guarantee there will be no overplotting, 
# so always consider if it's the right choice.
g + 
  geom_point()

# Causes
# low-precision data
# integer data
# All points on one axis

# Solutions: change alpha in combination with jitter
# Typically use position, here jitter
# 1 - Use the position argument
# Easy, most inflexible
g + 
  geom_point(position = "jitter", alpha = 0.65, shape = 16)

# 2 - Use the geom_jitter()
# Convenient, inflexible but can at least change height and width
g + 
  geom_jitter(alpha = 0.65, shape = 16)

# 3 - Use a position_*() function
# Most flexible and full-featured
posn_j <- position_jitter(seed = 136)
g + 
  geom_point(position = posn_j, alpha = 0.65, shape = 16)

library(car)
str(Vocab)
# vocabulary vs education
p <- ggplot(Vocab, aes(education, vocabulary)) 

# Default
p +
  geom_point()

# alpha, position and 
p +
  geom_point(alpha = 0.25, 
             shape = ".",
             position = posn_j)

# AESTHETIC - MAPPING a variable onto a SCALE (i.e. axis, aes)
# ATTRIBUTE - SETTING how a geometry looks
# ATTR override AES

# Additional exercises ----
# 3 - Add linear models, without background
# 4 - Re-position the legend to the upper left corner
# legend position is in units of npc

# 5 - Change the colors - use Dark2 from color brewer
# or the myBlues colors
# Recall: aesthetics == scales == axis

# 6 - Remove non-data ink
# 7 - Relabel the axes, add a title or caption
# Title: "The Iris Dataset, again!"
# Caption: "Anderson, 1931"

# 8 - Change the aspect ratio
# 9 - Set limits on the x and y axes
# 10 - Extra, remove color and use facets instead

g + 
  geom_jitter(alpha = 0.65, shape = 16)  +
  geom_smooth(se = FALSE, method = "lm") +
  coord_fixed(1, 
              xlim = c(4,8),
              ylim = c(2, 5),
              expand = 0) +
  scale_color_brewer(palette = "Dark2") +
  labs(title = "The Iris Dataset, again!",
       caption = "Anderson, 1931",
       color = "Iris species",
       x = "Sepal Length (cm)",
       y = "Sepal Width (cm)") +
  theme_classic(base_size = 6) +
  theme(axis.text = element_text(color = "black"),
        legend.position = c(0.1, 0.85))

# Saving the plot:
# Raster: png, jpg, gif, bmp, tif
# pixels and resolution
ggsave("myPlot.png", width = 10, height = 8, units = "cm")

# Vector: svg, pdf, ps, eps, il
# instructions to draw an image
# (may have embedded raster images)
ggsave("myPlot.pdf", width = 10, height = 8, units = "cm")

# using scales for limits - FILTERS out data not in the range
# scale_x_continuous(limits = c(4,8), expand = c(0,0)) +
# scale_y_continuous(limits = c(2, 5), expand = c(0,0)) +
  
# quick and easy  
  # scale_color_brewer(palette = "Dark2") +

# Define my own vector
  # scale_color_manual(values = myBlues) +

# Name a color for each group:
# Specifying which group gets which color:
# using a named vecor
myColors_named <- c(virginica = "#377EB8", 
                    setosa = "#4DAF4A", 
                    versicolor = "#984EA3")
munsell::plot_hex(myColors_named)

g + 
  geom_jitter(alpha = 0.65, shape = 16)  +
  geom_smooth(se = FALSE, method = "lm") +
  scale_color_manual(values = myColors_named) +
  theme(legend.position = c(0.1, 0.9))

# other suggestions
# theme(rect = element_blank(),
#       legend.position = c(0.1, 0.9))

