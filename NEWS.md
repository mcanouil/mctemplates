# mctemplates 0.3.0

## Minor improvements and fixes

* In `R/create_project.R`, 
    - Add `outputs` directory.

# mctemplates 0.2.9

## Minor improvements and fixes

* In `R/theme_black.R`,
    - fix label filled in black for light theme, now filled with background colour.
* In `/inst/rmarkdown/templates/report/skeleton/sleleton.Rmd`,  
    - Update affiliation.
    - Fix params DPI no longer used.
    - Minor style change.

# mctemplates 0.2.8

## Minor improvements and fixes

* In `R/theme_black.R`,
    - fix boxplot filled in black for light theme, now filled with background colour.
* In `/inst/rmarkdown/templates/report/skeleton/sleleton.Rmd`, 
    - restyle setup chunk.
    - simplify yaml header.
* In `/inst/rmarkdown/templates/ioslides/skeleton/sleleton.Rmd`, 
    - use ressources as global yaml parameters.

# mctemplates 0.2.7

## Minor improvements and fixes

* In `R/theme_black.R`, fix replacement of `NA` for default colours.

# mctemplates 0.2.6

## Minor improvements and fixes

* In `DESCRIPTION`, add remotes for `prompt`.

# mctemplates 0.2.5

## Minor improvements and fixes

* In `R/html_report.R`, fix parameters not used internally.

# mctemplates 0.2.4

## Minor improvements and fixes

* In `R/rprofile.R`, fix lib.loc for prompt.

# mctemplates 0.2.3

## Minor improvements and fixes

* In `R/rprofile.R`, 
    - fix `usethis` option not set properly.
    - add version to profile startup messages.

# mctemplates 0.2.2

## Minor improvements and fixes

* In `R/theme_black.R`, add new theme components from `ggplot2 v3.3.0`.
* In `/inst/rmarkdown/templates/report/skeleton/sleleton.Rmd`, 
    - replace `kableExtra` with `gt`.
    - use knit hook to render in `docs`.
* In `/inst/rmarkdown/templates/ioslides/skeleton/sleleton.Rmd`, 
    - replace `kableExtra` with `gt`.
    - use knit hook to render in `docs`.
* In `/inst/rmarkdown/templates/powerpoint/skeleton/sleleton.Rmd`, 
    - use knit hook to render in `docs`.
* In `R/create_ioslides.R`, use `docs` and `R` directories.
* In `R/rprofile.R`, remove hard coded values for authors.

# mctemplates 0.2.1

## New feature

* `mcprofile()` allows to set locales on unix-like machine.

## Minor improvements and fixes

* Fix empty lines in `.Renviron` written with `mcprofile()`.

# mctemplates 0.2.0

## New feature

* `mcprofile()` allows to setup .Rprofile with a predefined configuration.

# mctemplates 0.1.0

## New features

* Added a `NEWS.md` file to track changes to the package.
* Added a `theme_black()` which modifies default ggplot2 functions 
    such as: `print()`, `plot()`, `theme_set()` and `ggsave()`.
* Added a RStudio project template `Mickaël CANOUIL - RStudio Project Templates`
* Added a RStudio project template `Mickaël CANOUIL - RStudio Project Templates for ioslides`
* Added Rmarkdown templates for:
    - ioslides - `MC - ioslides`
    - PowerPoint - `MC - PowerPoint`
    - report - `MC - Report`
    - resume - `MC - Resume`
