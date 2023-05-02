
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NPSdataverse

<img src="man/figures/NPSdataverse_overview.jpg" width="100%" style="display: block; margin: auto;" />
NPSdataverse loads a suite of R packages for creating, manipulating, and
accessing data packages including interacting with DataStore. This is an
early version of the NPSdataverse. Please request enhancements and bug
fixes through
[Issues](https://github.com/nationalparkservice/NPSdataverse/issues).

## Installation

You can install the development version of NPSdataverse from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("nationalparkservice/NPSdataverse")
```

NPSdataverse will install the following R packages:

| Package               | Location                                           |
|-----------------------|----------------------------------------------------|
| **QCkit**             | <https://nationalparkservice.github.io/QCkit/>     |
| EMLassemblyline (EAL) | <https://ediorg.github.io/EMLassemblyline/>        |
| EML                   | <https://www.cran-e.com/package/EML>               |
| **EMLeditor**         | <https://nationalparkservice.github.io/EMLeditor/> |
| **DPchecker**         | <https://nationalparkservice.github.io/DPchecker/> |
| **NPSutils**          | <https://nationalparkservice.github.io/NPSutils/>  |

------------------------------------------------------------------------

(R packages in **bold** are developed by NPS)

## Updating R packages

Many of the NPSdataverse packages are in a phase of rapid development.
NPSdataverse will check for new versions of the packages stored on gitub
(all the packages except r/EML) each time you load NPSdataverse. If any
of your packages are out of date, please follow the instructions to
update them.

## Creating data packages

If you are you are creating a data package and need to generate EML
metadata make sure all of your .csv data files are in a single folder.

After loading NPSdataverse, from within Rstudio select the “File” menu.
Select “New File” from the drop down menu and choose “R Markdown”. In
the dialog box that pops up, select “From Template” and then click on
the template labelled “Editable_EML_Creation_Workflow” and click “OK”.

<img src="man/figures/open_rmd.png" width="45%" style="display: block; margin: auto;" />

<img src="man/figures/EMLtemplate.png" width="45%" style="display: block; margin: auto;" />

This will open a new file on that you can edit to generate EML metadata
for your data package. See the [web pages associated with
EMLeditor](https://nationalparkservice.github.io/EMLeditor/) for
additional information, instructions, and examples.
