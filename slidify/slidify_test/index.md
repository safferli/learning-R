---
title       : a slidify test
subtitle    : fancy shit!
author      : Christoph Safferling 
job         : Ubisoft Blue Byte
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...} 
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---

<!-- these will override the defauls -->
<style>
    .title-slide {
        background-color: #FFFFFF; /* #EDE0CF; #CBE7A5; #CA9F9D*/
    }

    .title-slide hgroup > h1{
        font-family: 'Oswald', 'Helvetica', sanserif; 
    }

    .title-slide hgroup > h1, 
    .title-slide hgroup > h2 {
        color: #535E43 ;  /* ; #EF5150*/
    }
</style>




## Read-And-Delete

1. Edit YAML front matter
2. Write using R Markdown
3. Use an empty line followed by three dashes to separate slides!

--- .class #id 

## Slide 2

text in here class id

--- 

## slide 3

- test unordered lists
- nothing fancy

--- #custbg

## Slide with custom background

<style>
#custbg {
  background-image:url(images/bluebyte.jpg); 
  background-repeat: no-repeat;
  background-position: center center;
  background-size: 15%;
}
</style>

- one to test overwrite
- two to test overwrite
- lower
- lower again
- three to test overwrite three to test overwrite three to test overwrite



