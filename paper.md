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

NPSdataverse is a suite of R packages modeled off of the tidyverse concept of several packages built with a common goal [@Wickham2019]. The overarching theme of the NPSdataverse packages is creating, publishing, and accessing open, machine-readable data and metadata. NPSdataverse supports Ecological Metadata Language (EML) metadata and .csv data files. The NPSdataverse contains some of the constituent packages (R/EML and R/EMLassemblyline) are general-use and aimed at authoring EML documents. Other packages (R/QCkit, R/EMLeditor, R/DPchecker and R/NPSutils) are designed and maintained by the National Park Service. Although many functions within the NPSdataverse packages are NPS-specific (particularly API calls), all of the functions are written so that they can also be used by the general public. Anyone interested applying for research permits or conducting research on National Park Units can reference and utilize the NPSdataverse packages. Additionally, the packages will be useful for data management plans in wide variety of grant proposals and for anyone that needs to create open data and machine readable metadata. Finally, the ability to author, edit, and check EML metadata will be useful for data publication at any number of repositories or data journals.

# Statement of need

Following a long-term movement for transparency and data accessibility, the U.S. implemented an Open Data Memorandum in 2013 (OMB M-13-13) and the federal OPEN Government Data Act of 2019 [@OpenData2019]. The Open Data Act mandated that federal agencies provide data in open formats with metadata. Subsequently, many funding agencies such as the National Science Foundation have required grant awardees to make data public, often including metadata ([@nsf2015]). Multiple publishers have followed suit ([@Wiley2022], [@Springer2023])) and require data availability statements upon publication. 

One goal of open science, and requirement of the recent "Nelson Memo" is to make data findable, interoperable, accessible, and reuseable ([@Nelson2022]). These goals are often achieved by including structured, machine-readable metadata that conforms to a defined schema along with the data. Ecological Metadata Language Metadata (EML) is one metadata standard that is particularly amenable to studies with rich taxonomy ([@EML2019]). It has been adopted by multiple research organizations including the Ecological Data Initiative (EDI), the National Ecological Observatory Network (NEON), the Global Biodiversity Information Facility (GBIF), Swedish Biodiversity Data Infrastructure (SBDI), the French Biodiversity Hub ("Pole National de Donnees de Biodiversite"), the U.S. National Park Service, and others. 

Nevertheless, actual availability of data varies ([@Federer2018, @Tedersoo2021], perhaps because there is a need for more infrastructure and tools to meet the goals of open data and open science ([@Huston2019]). Multiple solutions have been presented, including ezEML, a workflow for authoring metadata in Ecological Metadata Language and publishing data and metadata to a repository ([@Vanderbilt2022]). ezEML is has an intuitive graphical user interface with a relatively low learning curve; however, it does have some drawbacks. For instance, ezEML is not scriptable, which makes repeated deployments of the same or similar workflows challenging. And, ezEML requires the user upload their data to an external site for processing, which may not be suitable for sensitive data. Here we introduce the NPSdataverse, a series of R-based packages for authoring, editing, and checking EML metadata locally in a scriptable fashion. Packages within the NPSdataverse leverage early work using R to create and manipulate XML based EML files ([@Boettiger2019]). Building upon that framework, we add user-friendly EML creation workflows; integration with taxonomic databases; fast, easy editing of existing metadata; congruence checks to test correspondence between data and metadata; and integration with public repositories such as DataStore. Packages within the NPSdataverse also include data munging and data access/download functions that leverage the rich EML associated with the data.  


# NPSdataverse R package

The NPSdataverse package is a meta-package that loads packages within the NPSdataverse into R. NPSdataverse will automatically check that the latest version of the main development branch on GitHub is being loaded. If updates are indicated, the user will be alerted and given instructions on how to update the relevant packages. To prevent API limits on GitHub.com, the package only checks for updates from an interactive R session and will skip checks when the system is not on-line or GitHub.com is not responding.

# QCkit R package

QCkit is primarily a data munging package designed to prepare data for metadata creation and publication. QCkit includes functions that can help manage date-time formatting, can check data files for threatened or endangered species, and can help increase interoperability by suggesting appropriate darwinCore column names. Additional functions allow users to convert between decimal latitude and longitude and UTMs, check whether GPS coordinates fall within specific National Park Service unit boundaries, add elevation based on GPS locations via a USGS API, and help deal with "missing values". QCkit also facilitates documenting data munging by generating DataStore references, which can have DOIs attached to them, based on GitHub.com releases. 

# EML R package

The EML package is a fundamental package that allows for importing .xml files, creating and validating validating EML within R, and writing R objects back out to .xml files. R/EML allows for creating fully fledged Ecological Metadata Language Metadata files using nested S3 lists within R while relying on the R/emld package.

# EMLassembyline R package

The EMLassemblyline package builds upon R/EML and adds substantial functionality. For instance, EMLassemblyline allows the user to supply .csv files, which are then used to generate template .txt files. Users can adjust the template files as needed and use the `make_eml()` function to generate an R-object that can be exported via R/EML as an EML-fomatted .xml file. EMLassemblyline includes the ability generate entire taxonomic backbones from lists of scientific names via API calls to ITIS, GBIF, or Worms. EMLassemblyline will validate the R object against the EML schema and provide helpful hints on what might have gone wrong during the `make_eml()` process.  EMLassemblyline provides an efficient bridge between data and EML metadata for users who are familiar with R but may not be on the EML schema or the detailed nested lists needed to create EML. Products from the EMLassemblyline pipeline are suitable for publication at multiple repositories including the Environmental Data Initiative. 

# EMLeditor R package

The EMLeditor package allows users to quickly and easily view components of metadata in R and make on-the-fly edits to metadata without having to re-run the EMLassemblyline steps (these can be time consuming, especially if there are many taxa that need to be resolved). EMLeditor includes the ability to pick specific licenses (CC0, CC-BY, etc), add ORCIDs, include organizations as authors, and much more. EMLeditor also adds specific content necessary to be compliant with the National Park Service' DataStore. With the proper permissions, EMLeditor can be used to generate draft references and reserve DOIs on DataStore as well as upload data and metadata files to DataStore. Finally, EMLeditor contains a .rmd template file that is accessible in Rstudio under Files > New File > R markdown. The template provides an editable script that walks the user through using EMLassemblyline, EMLeditor, and DPchecker to create and validate EML metadata.

# DPchecker R Package

The DPchecker package provides detailed feedback on data-metadata congruence. DPchecker goes beyond validating EML objects in R against the EML schema. Using the `run_congruence_checks` function, DPchecker will conduct a series of 46 checks. These are divided into several categories: Metadd to ensure that metadata are well formatted (file names are not duplicated, all data files are in the metadata file, no data files are not in the metadata file)


brief description of the various component packages

# In-text Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

If you want to cite a software repository URL (e.g. something on GitHub
without a preferred citation) then you can do it with the example BibTeX
entry below for \@fidgit.

For a quick reference, the following citation commands can be used: -
`@author:2001` -\> "Author et al. (2001)" - `[@author:2001]` -\>
"(Author et al., 2001)" - `[@author1:2001; @author2:2001]` -\> "(Author1
et al., 2001; Author2 et al., 2002)"

# Figures

Figures can be included like this: ![Caption for example
figure.](figure.png) and referenced from text using
\autoref{fig:example}.

Figure sizes can be customized by adding an optional second parameter:
![Caption for example figure.](figure.png){width="20%"}

# Acknowledgements

We acknowledge contributions from across the National Park Service, but
in particular from the Inventory and Monitoring Division. Members of the
NPS Long Term Data Management Governing Board provided critical guidance
and insight (in addition to several of the authors, these include
Kristen Bonebrake, Adam Kozlowski, Ryan Monello, Mark Isley, and Megan
Swan). Justin Mills (currently at U.S. Fish and Wildlife Service) and
Derrick Dardano helped with navigating API and Active Directory
interfaces, Marsha Leavitt made and explained numerous updates to
DataStore. Dan Gussett, Kate Miller, and Pete Budde facilitated software
availability, and Meg White supported and endorsed the project. We are
particularly indebted to our strong user base and their very helpful
feedback including Alison Loar, Christina Appleby, Kirk Sherrill, Lisa
Nelson and Tom Phillipi. Numerous Student Conservation Association
interns made contributions to the code base including Sarah Kelso, James
Brown, and Amy Sherman. Alissa Graff (currently at the Internal Revenue
Service) provided important input on early versions of NPSutils.

# References
