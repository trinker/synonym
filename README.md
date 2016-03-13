synonym   [![Follow](https://img.shields.io/twitter/follow/tylerrinker.svg?style=social)](https://twitter.com/intent/follow?screen_name=tylerrinker)
============


[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/trinker/synonym.svg?branch=master)](https://travis-ci.org/trinker/synonym)
[![Coverage
Status](https://coveralls.io/repos/trinker/synonym/badge.svg?branch=master)](https://coveralls.io/r/trinker/synonym?branch=master)
<a href="https://img.shields.io/badge/Version-0.0.1-orange.svg"><img src="https://img.shields.io/badge/Version-0.0.1-orange.svg" alt="Version"/></a>
</p>
<img src="inst/synonym_logo/r_synonym.png" width="150" alt="readability Logo">

**synonym** is a synonyms data set wrapped with a few tools for quickly
looking up relevant synonyms.

<img src="inst/synonym_logo/synonym_humor.png" width="200" alt="readability Logo">


Table of Contents
============

-   [Functions](#functions)
-   [Demonstration](#demonstration)
-   [Installation](#installation)
-   [Contact](#contact)

Functions
============


<table>
<thead>
<tr class="header">
<th align="left">Function</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left"><code>get_sentiment</code></td>
<td align="left">Lookup relevant synonyms</td>
</tr>
<tr class="even">
<td align="left"><code>drop_zero</code></td>
<td align="left">Drop <code>NA</code>s* from <code>get_synonym</code> objects</td>
</tr>
</tbody>
</table>

\**These were terms that are in the synonym key but did not meet the
relevant distance.*

Demonstration
=============

    get_synonym(c('cat', 'dog', 'chicken', 'dfsf'))

    ## $cat
    ## [1] NA
    ## 
    ## $dog
    ## [1] "puppy"  "pup"    "shadow" "hound"  "plague" "haunt" 
    ## 
    ## $chicken
    ## [1] "poultry" "hen"

    get_synonym('cat', 1)

    ## $cat
    ## [1] NA

    get_synonym('cat', 2)

    ## $cat
    ##  [1] "puma"    "panther" "tabby"   "kitty"   "lynx"    "tiger"   "cougar" 
    ##  [8] "lion"    "puss"    "kitten"  "leopard" "bobcat"  "jaguar"  "tomcat" 
    ## [15] "pussy"   "ocelot"  "tom"     "cheetah" "mouser"

    get_synonym('cat', 3)

    ## $cat
    ## [1] "grimalkin" "malkin"

    get_synonym('cat', 2:3)

    ## $cat
    ##  [1] "puma"      "panther"   "tabby"     "kitty"     "lynx"     
    ##  [6] "tiger"     "cougar"    "lion"      "puss"      "kitten"   
    ## [11] "leopard"   "bobcat"    "jaguar"    "tomcat"    "pussy"    
    ## [16] "ocelot"    "tom"       "cheetah"   "mouser"    "grimalkin"
    ## [21] "malkin"

    drop_zero(
        get_synonym(c('cat', 'dog', 'chicken', 'dfsf'))
    )

    ## $dog
    ## [1] "puppy"  "pup"    "shadow" "hound"  "plague" "haunt" 
    ## 
    ## $chicken
    ## [1] "poultry" "hen"

Installation
============

To download the development version of **synonym**:

Download the [zip
ball](https://github.com/trinker/synonym/zipball/master) or [tar
ball](https://github.com/trinker/synonym/tarball/master), decompress and
run `R CMD INSTALL` on it, or use the **pacman** package to install the
development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_gh("trinker/synonym")

Contact
=======

You are welcome to:   - submit suggestions and bug-reports at: <https://github.com/trinker/synonym/issues>   - send a pull request on: <https://github.com/trinker/synonym/>  
 compose a friendly e-mail to: <tyler.rinker@gmail.com>