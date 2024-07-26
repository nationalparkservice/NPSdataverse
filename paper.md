---
title: 'NPSdataverse: a suite of R packages for data munging, authoring Ecological Metadata Language metadata, checking data-metadata congruence, and accessing data'
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
authors:
  - name: Robert L. Baker
    orcid: 0000-0001-7591-5035
    equal-contrib: true
    affiliation: 1
  - name: Collin Smith
    orcid: 0000-0003-2261-9931
    equal-contrib: true
    affiliation: "2, 3"
  - name: Sarah E. Wright
    orcid: 0009-0004-5060-2189
    equal-contrib: true
    affiliation: 1
  - name: Issac Quevedo
    orcid: 0000-0003-0129-981X
    equal-contrib: true
    affiliation: 4
  - name: Kristin Vanderbilt
    orcid: 0000-0003-1439-2204
    equal-contrib: true
    affiliation: 1
  - name: Judd M. Patterson
    orcid: 0000-0002-0951-7917
    equal-contrib: true
    affiliation: 1
  - name: Joe DeVivo
    orcid: 0000-0002-0414-7865
    equal-contrib: true
    affiliation: 1
affiliations:
  - name: National Park Service, USA
    index: 1
  - name: Environmental Data Initiative, USA
    index: 2
  - name: University of Wisconsin, USA
    index: 3
  - name: Student Conservation Association, USA
    index: 4
date: 24 July 2024
bibliography: paper.bib
editor_options: 
  markdown: 
    wrap: 72
---

# Summary

NPSdataverse is a suite of R packages modeled off of the tidyverse
concept of several packages built with a common goal [@Wickham2019]. The
overarching theme of the NPSdataverse packages is creating, publishing,
and accessing Open, machine-readable data and metadata. NPSdataverse
supports Ecological Metadata Language (EML) metadata and .csv data
files. Some of the constituent packages (R/EML and R/EMLassemblyline)
are general-use packages aimed at authoring EML documents. Additional
packages (R/QCkit, R/EMLeditor, R/DPchecker and R/NPSutils) are designed
and maintained by the National Park Service. Although many functions
within the NPSdataverse packages are NPS-specific (particularly API
calls), or have default parameters with NPS staff in mind, all of the
functions are written so that they can be used by the general public.
Anyone interested applying for research permits or conducting research
on National Park Units can reference and utilize the NPSdataverse
packages. Additionally, the packages will be useful for data management
plans in wide variety of grant proposals and for anyone that needs to
create Open data and machine readable metadata to comply with the Open
Data Act of 2018. Finally, the ability to author, edit, and check EML
metadata will be useful for data publication at any number of
repositories or data journals.

# Statement of need

Some text with maybe some background, history, citations, etc pointing
out the need for the software

# NPSdataverse package

Brief description of the NPSdataverse package: When a user is on-line
and loads the NPSdataverse into R, NPSdataverse will automatically check
that the latest version of the main development branch on GitHub is
being loaded. If not, the user will be alerted and given instructions on
how to update the relevant packages.

# Component packages

brief description of the various component packages

# In-text Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

If you want to cite a software repository URL (e.g. something on GitHub
without a preferred citation) then you can do it with the example BibTeX
entry below for @fidgit.

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
