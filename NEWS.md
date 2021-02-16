# mctemplates (development version)

* In `R/rprofile.R`,
    + Setup locales for Windows system.
* In `R/create_ioslides.R`,
    + Fix missing `gert::git_add`.
    + Update default `DESCRIPTION`.
    + Remove `R` directory.
* In [rmarkdown templates](inst/rmarkdown/templates),
    + Update ioslides to wide format for figures.

# mctemplates 0.6.0

* In [rmarkdown templates](inst/rmarkdown/templates),
    + Remove PowerPoint template.
* In `R/create_project.R`,
    + Use `gert`.
    + Add "LineEndingConversion" to `.Rproj`.
* In `R/create_ioslides.R`,
    + Use `gert`.
    + Add "LineEndingConversion" to `.Rproj`.
    + Update default `DESCRIPTION`.
* In `R/theme_black.R`,
    + No documentation for internals.
* In `R/rprofile.R`,
    + Use `gert`.
    + Remove Github/Gitlab token arguments.
    + No longer rely on `prompt`.
* In `R/check_commit.R`,
    + New function to check if commits were made in projects.

# mctemplates 0.5.2

* In `R/ioslides_presentation.R`,
    + Update with new logo.

* In [rmarkdown templates](inst/rmarkdown/templates),
    + Update with new logo.
    + Tweak css style:
        - Decrease font size for code.
        - Extend background code ribbons to full screen.

# mctemplates 0.5.1

* In `R/rprofile.R`,
    + Fix `usethis.full_name`.

# mctemplates 0.5.0

* MIT License
* In `R/rprofile.R`,
    + Set default rule width to `80`.
* In `DESCRIPTION`,
    - Update dependencies.
* In `R/ioslides_presentation.R`,
    + Update not exported function from `rmarkdown`.
* In [rmarkdown templates](inst/rmarkdown/templates/ioslides/resources),
    + Update affiliation.

# mctemplates 0.4.7

* In `R/rprofile.R`,
    + Fix `Authors@R` filed for `usethis`.

# mctemplates 0.4.6

* In [rmarkdown templates](inst/rmarkdown/templates/ioslides/resources),
    + Add Font-Awesome 5.14.0 icons to ioslides.
* In `R/ioslides_presentation.R`,
    + Update to include Font-Awesome 5.14.0 icons.

# mctemplates 0.4.5

* In [rmarkdown templates](inst/rmarkdown/templates),
    + Update affiliation.

# mctemplates 0.4.4

* In [rmarkdown templates](inst/rmarkdown/templates),
    + Minor code change.
    + Move knitr settings after libary loading section.

# mctemplates 0.4.3

* In [rmarkdown templates](inst/rmarkdown/templates),
    + Remove css style for tables.

# mctemplates 0.4.2

* In [rmarkdown templates](inst/rmarkdown/templates),
    + Reorder code in setup chunk.

# mctemplates 0.4.1

## Minor improvements and fixes

* In `R/theme_black.R`,
    - Fix `theme_black_md()`.

# mctemplates 0.4.0

## New feature

* In `DESCRIPTION`,
    - Use `ggtext`.
    - Update dependencies.
* In `R/theme_black.R`,
    - New `theme_black_md()` using `ggtext`.
* In [rmarkdown templates](inst/rmarkdown/templates),
    - Update all templates setup chunk and YAML header.

## Minor improvements and fixes

* Use `ggplot2` internal function to compute background colour in device.
* Fix ioslide template

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
