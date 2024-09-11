---
title: "NPSdataverse: a suite of R packages for data munging, authoring Ecological
  Metadata Language metadata, checking data-metadata congruence, and accessing data"
tags:
- R
- metadata
- Ecological Metadata Language
- data
- National Park Service
- Environmental Data Initiative
- machine readable
- Open
- FAIR
- DataStore
- data package
- data publication
- data access
date: "19 August 2024"
output: pdf_document
authors:
- name: Robert L. Baker
  orcid: "0000-0001-7591-5035"
  equal-contrib: true
  affiliation: 1
- name: Collin Smith
  orcid: "0000-0003-2261-9931"
  equal-contrib: true
  affiliation: 2, 3
- name: Sarah E. Wright
  orcid: "0009-0004-5060-2189"
  equal-contrib: true
  affiliation: 1
- name: Issac Quevedo
  orcid: "0000-0003-0129-981X"
  equal-contrib: true
  affiliation: 4
- name: Kristin Vanderbilt
  orcid: "0000-0003-1439-2204"
  equal-contrib: true
  affiliation: 1
- name: Carl Boettiger
  orcid: "0000-0002-1642-628X"
  affiliation: 5
- name: Judd M. Patterson
  orcid: "0000-0002-0951-7917"
  equal-contrib: true
  affiliation: 1
- name: Joe DeVivo
  orcid: "0000-0002-0414-7865"
  equal-contrib: true
  affiliation: 1
bibliography: paper.bib
editor_options:
  markdown:
    wrap: 72
affiliations:
- name: National Park Service, USA
  index: 1
- name: Environmental Data Initiative, USA
  index: 2
- name: University of Wisconsin, USA
  index: 3
- name: Student Conservation Association, USA
  index: 4
- name: University of California, Berkeley, USA
  index: 5
---

# Summary

The [NPSdataverse](https://nationalparkservice.github.io/NPSdataverse/) is a suite of R packages modeled off of the tidyverse concept of several packages built with a common goal [@Wickham2019]. The overarching theme of the NPSdataverse packages is creating, publishing, and accessing open, machine-readable data and metadata. NPSdataverse supports Ecological Metadata Language (EML) metadata and .csv data files. Some of the constituent packages ([R/EML](https://docs.ropensci.org/EML/) and [R/EMLassemblyline](https://ediorg.github.io/EMLassemblyline/)) are general-use and aimed at authoring EML documents. Other packages ([R/QCkit](https://nationalparkservice.github.io/QCkit/), [R/EMLeditor](https://nationalparkservice.github.io/EMLeditor/), [R/DPchecker](https://nationalparkservice.github.io/DPchecker/) and [R/NPSutils](https://nationalparkservice.github.io/NPSutils/)) are designed and maintained by the National Park Service (NPS). Although many functions within the NPSdataverse packages are NPS-specific (particularly some API calls), all of the functions are written so that they can also be used by the general public. Anyone interested applying for research permits or conducting research on NPS Units can reference and utilize the NPSdataverse packages. Additionally, the packages will be useful for data management plans in wide variety of grant proposals and for anyone that needs to create open data and machine readable metadata. Finally, the swiftly and easily ability to author, edit, and check Ecological Metadata Language (EML) metadata in a reproducible fashion will be useful for data publication at any number of repositories or data journals.

# Statement of Need

Following a long-term movement for transparency and data accessibility, the U.S. implemented an Open Data Memorandum in 2013 (OMB M-13-13) and the federal OPEN Government Data Act of 2019 [@OpenData2019]. The Open Data Act mandated that federal agencies provide data in open formats with metadata. Subsequently, many funding agencies such as the National Science Foundation have required grant awardees to make data public, often including metadata ([@nsf2015]). Multiple publishers have followed suit ([@Wiley2022], [@Springer2023])) and require data availability statements upon publication. 

One goal of open science, and requirement of the recent "Nelson Memo" is to make data FAIR: findable, inter-operable, accessible, and reuseable ([@Nelson2022], [@Wilkinson2016]). These goals are often achieved by including structured, machine-readable metadata that conforms to a defined schema along with the data. Ecological Metadata Language Metadata (EML) is one metadata standard that is particularly amenable to studies with rich taxonomy ([@Jones2006], [@EML2019]). It has been adopted by multiple research organizations including the Ecological Data Initiative (EDI), the National Ecological Observatory Network (NEON), the Global Biodiversity Information Facility (GBIF), Swedish Biodiversity Data Infrastructure (SBDI), the French Biodiversity Hub ("Pole National de Donnees de Biodiversite"), the U.S. National Park Service, and others. 

Nevertheless, actual availability of data varies ([@Federer2018, @Tedersoo2021], perhaps because there is a need for more infrastructure and tools to meet the goals of open data and open science ([@Huston2019]). Multiple solutions have been presented, including ezEML, a workflow for authoring metadata in Ecological Metadata Language and publishing data and metadata to a repository ([@Vanderbilt2022]). ezEML is has an intuitive graphical user interface with a relatively low learning curve; however, it does have some drawbacks. For instance, ezEML is not scriptable, which makes repeated deployments of the same or similar workflows challenging. And, ezEML requires the user upload their data to an external site for processing, which may not be suitable for sensitive data. Here we introduce the NPSdataverse, a series of R-based packages for authoring, editing, and checking EML metadata locally in a scriptable fashion. Packages within the NPSdataverse leverage earlier work using R to create and manipulate XML based EML files ([@Boettiger2019]). Building upon that framework, we add user-friendly EML creation workflows; integration with taxonomic databases; fast, easy editing of existing metadata; congruence checks to test correspondence between data and metadata; and integration with public repositories such as the National Park Service's [DataStore](https://irma.nps.gov/DataStore/). Packages within the NPSdataverse also include data munging and data access/download functions that leverage the rich EML associated with the data.  


# NPSdataverse R package

The [NPSdataverse](https://nationalparkservice.github.io/NPSdataverse/) package is a meta-package that loads packages within the NPSdataverse into R. It provides a convenient way to download many of the packages needed to create and access data packages consisting of rich Ecological Metadata Language metadata and .csv data files:

```{r install_NPSdataverse, eval = FALSE}
pak::pkg_install("nationalparkservice/NPSdataverse")
```
NPSdataverse will automatically check that the latest version of the main development branch on GitHub is being loaded. If updates are indicated, the user will be alerted and given instructions on how to update the relevant packages. To prevent API limits on GitHub.com, the package only checks for updates from an interactive R session and will skip checks when the system is not on-line or GitHub.com is not responding.

# QCkit R package

[QCkit](https://nationalparkservice.github.io/QCkit/) is primarily a data munging package designed to prepare data for metadata creation and publication. QCkit includes functions that can help manage date-time formatting, can check data files for threatened or endangered species, and can help increase inter-operability by suggesting appropriate [Darwin Core](https://dwc.tdwg.org/) standards for naming data. Additional functions allow users to convert between decimal latitude and longitude and UTMs, check whether GPS coordinates fall within specific National Park Service unit boundaries, add elevation based on GPS locations via a USGS API, and help deal with "missing values". QCkit also facilitates documenting data munging by generating DataStore references based on GitHub.com releases. The DataStore references can hold processing scripts or code packages and have DOIs attached to them. 

# EML R package

The R/[EML](https://docs.ropensci.org/EML/) package is a fundamental package that allows for importing .xml files, creating and validating validating EML within R, and writing R objects back out to .xml files. R/EML allows for creating fully fledged Ecological Metadata Language Metadata files using nested S3 lists within R while relying on the R/[emld](https://docs.ropensci.org/emld/) package [@Boettiger2019_emld].

# EMLassembyline R package

The [EMLassemblyline](https://ediorg.github.io/EMLassemblyline/) (EAL) package builds upon R/EML and adds substantial functionality. For instance, EAL allows the user to supply .csv files, which are used to generate template .txt files. Users can adjust the template files as needed and use the `EMLassemblyline::make_eml()` function to generate an R-object that can be exported via R/EML as an EML-fomatted .xml file. EAL includes the ability generate entire taxonomic backbones from lists of scientific names via API calls to ITIS, GBIF, or Worms. EAL will validate the R object against the EML schema and provide helpful hints on what might have gone wrong during the `EMLassemblyline::make_eml()` process.  EAL provides an efficient bridge between data and EML metadata for users who are familiar with R but may not be experts on the EML schema or the detailed nested lists needed to create EML within R via R/EML. Products from the EAL pipeline are suitable for publication at multiple repositories including the Environmental Data Initiative.

# EMLeditor R package

The [EMLeditor](https://nationalparkservice.github.io/EMLeditor/) package allows users to quickly and easily view components of metadata in R and make on-the-fly edits to metadata without having to re-run the EAL steps (EAL can be time consuming, especially if there are many taxa that need to be resolved). EMLeditor includes the ability to pick specific licenses (CC0, CC-BY, etc), add [ORCIDs](https://orcid.org/), include organizations as authors, and much more. EMLeditor also adds specific content necessary to be compliant with NPS's DataStore. With the proper permissions, EMLeditor can be used to generate draft references and reserve DOIs on DataStore as well as upload data and metadata files to DataStore. Finally, EMLeditor contains a .rmd template file that is accessible in Rstudio under Files > New File > R markdown. The template provides an editable script that walks the user through using EAL, EMLeditor, and DPchecker to create and validate EML metadata in R.

EMLeditor "set" class functions (which all begin with "set_" such as "`EMLeditor::set_abstract()`") will add several NPS-specific items to metadata using their default settings. For instance, these functions will set NPS as the publisher, Fort Collins as the location, and will add a "for or by NPS = TRUE" statement to the metadata. To invoke these functions without adding the NPS-specific metadata elements, set the parameter `NPS = FALSE`. Non-NPS publisher information can be added using the `EMLeditor::set_publisher()` function with the parameters `for_or_by_NPS` and `NPS` set to `FALSE`:

```{r non-NPS-example, eval=FALSE}
new_metadata1 <- set_abstract(eml_object = old_metadata,
                            abstract = "This is example/test abstract text",
                            NPS = FALSE)
new_metadata2 <- set_publisher(eml_object = new_metadata1,
                            org_name = "My Institution",
                            street_address = "1234 Sesame St.",
                            city = "Anytown",
                            State = "Delaware",
                            zip_code = "12345",
                            country = "USA",
                            URL = "https://www.MyInstitution.us",
                            email = "publisher@myinstitution.us",
                            ror_id = "",
                            for_or_by_NPS = FALSE,
                            NPS = FALSE)
```
)

# DPchecker R Package

The [DPchecker](https://nationalparkservice.github.io/DPchecker/) package provides detailed feedback on data-metadata congruence for use by either data package authors and reviewers. DPchecker goes beyond validating EML objects in R against the EML schema. Using the `DPchecker::run_congruence_checks` function, DPchecker will conduct a series of 46 checks. These are divided into several categories: 1) Metadata to ensure that metadata are well formatted (file names are not duplicated, files specify the field delimiter, data files have URLs, the proper delimiter and header row numbers are present, etc. 2) Metadata elements necessary for DataStore automated extraction are present: creators have valid surnames, publication date is present and in the correct format, keywords are present, abstract and methods are present and well formatted, license is present, attributes have definitions, etc. 3) Recommended EML elements are present including ORCiDs and a notes section 4) Metadata and data are in congruence including all files listed in metadata and all metadata file names refer to data files, the columns in the metadata match the columns in the data files, missing fields in data files are properly documented in metadata, columns indicated as numeric in metadata are numeric in the data files, the date format in the metadata matches the date format in the data files, and dates in data files fall within the date ranges given in the metadata and 5) data and metadata compliance including tests for information that should not be released to the public such as non-.gov emails and GPS coordinates if the data package is not set to public. For each test, the data package may fail with an error, fail with a warning, or pass. When warnings and errors are generated, the user is pointed towards the appropriate EMLeditor function to address the problem. DPchecker will often throw a warning even if an item exists and is properly formatted but could by improved to increase the FAIR characteristics of the metadata. For instance, DPchecker will throw a warning if an abstract is less than 20 words long as it is unlikely the creator is able to meaningfully describe the data collection and processing in less than 20 words.

# NPSutils R Package

The [NPSutils](https://nationalparkservice.github.io/NPSutils/) package serves primarily as a way to access data. NPSutils provides avenues for directly downloading data from DataStore using R. NPSutils can also import data downloaded from any repository into R and take advantage of rich EML metadata to call column types. NPSutils provides some basic meta-analysis capability, assuming certain inter-operabilty standards are met (such as consistently naming columns with species or GPS coordinates). NPSutils can also be used to import data and metadata into common data visualization tools such as PowerBI.

# Acknowledgements

We acknowledge contributions from across the National Park Service, but in particular from the Inventory and Monitoring Division. Members of the NPS Long Term Data Management Governing Board provided critical guidance and insight (in addition to several of the authors, these include Kristen Bonebrake, Adam Kozlowski, Ryan Monello, Mark Isley, and Megan Swan). Justin Mills (currently at U.S. Fish and Wildlife Service) and Derrick Dardano helped with navigating API and Active Directory interfaces, Marsha Leavitt made and explained numerous updates to DataStore. Dan Gussett, Kate Miller, and Pete Budde facilitated software availability, and Meg White supported and endorsed the project. We are particularly indebted to our strong user base and their very helpful feedback including Alison Loar, Christina Appleby, Kirk Sherrill, Lisa Nelson and Tom Phillipi. Numerous Student Conservation Association interns made contributions to the code base including Sarah Kelso, James Brown, and Amy Sherman. Alissa Graff (currently at the Internal Revenue Service) provided important input on early versions of NPSutils.

# References
