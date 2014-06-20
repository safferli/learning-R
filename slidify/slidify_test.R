## install slidify stuff
#library(httr)
#set_config(use_proxy(url="10.26.0.16", port=3128))
require(devtools)
#install_github("slidify", "ramnathv")
install_github("slidifyLibraries", "ramnathv")

# Define your workspace: "C:/xxx/"
#workspace <- "/home/safferli/Documents/R-course/github/R-programming/week2/"
workspace <- "D:/github/learning-R/slidify/"
setwd(workspace)

library(slidify)
author("slidify_test")

# http://ramnathv.github.io/slidifyExamples/

# The title-slide in io2012 framework is marked with the class title-slide. So
# you can customize the slide using css. For example, if you want to specify a
# background image, you need to add the following css.
# 
# .title-slide { background-image: url(http://goo.gl/cF6W2); }
# 
# You can either add it directly to your Rmd file by enclosing it with
# <style></style> tags or to a custom css file in assets/css, which will
# automatically be included when you run slidify.

## http://stackoverflow.com/questions/22567127/slidify-how-to-customize-a-slide-background
#
# If it is a one off slide you are trying to add a background to, then the
# following will work
# 
# --- #custbg
# 
# ## Slide with custom background
# 
# <style> 
#    #custbg { 
#    background-image:url(C:/path/mypng.png); 
#    background-repeat: no-repeat; 
#    background-position: center center; 
#    background-size: cover; 
# } 
# </style>
# 
# If you have multiple slides where you want such a custom background, then you
# can take advantage of templates. So, rewrite the slide as below
# 
# --- &custbg bg:"C:/path/mypng.png"
# 
# ## Slide with custom background
# 
# Then create a layout named custbg.html and drop it in the assets/layouts
# folder from where slidify will automatically pick layouts. Here is a short
# explanation of what happens. The custbg.html layout inherits from the parent
# layout slide.html. Everything you see between {{{ and }}} is a placeholder to
# be populated by slidify. {{{ slide.html }}} contains the original slide
# content. We are appending to this content, dynamic styling by using the id
# attribute. Note that this layout only allows users to specify a bg in the
# slide. If you want you can customize other style attributes as well. The
# advantage of the layout approach is that you can allow multiple slides to take
# advantage of custom backgrounds.
# 
# --- layout: slide ---
# 
# {{{ slide.html }}}
# 
# <style> #{{{ slide.id }}} { background-image:url({{{ slide.bg }}}); 
# background-repeat: no-repeat; background-position: center center; 
# background-size: cover; } </style>
# 

slidify("index.Rmd")

# publish on github: 
#     Login with your github account and create a new repository. Note that
#     Github will prompt you to add a README file, but just use the defaults so
#     that your repo is empty. You will need to have git installed on your
#     computer and be able to push to github using SSH
# 
# # replace USER and REPO with your username and reponame
# publish(user = "USER", repo = "REPO", host = 'github')
