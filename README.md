# Public Transport Quality Grades Thesis

[![Build Status](https://travis-ci.org/public-transport-quality-grades/thesis.svg?branch=master)](https://travis-ci.org/public-transport-quality-grades/thesis)

This repository contains the bachelor thesis written in LaTeX. The PDF is built using Travis.

## Abstract

Public transport quality gradings ("ÖV-Güteklassen") are used to measure the coverage radius of public transportation stations by distance and time.
The currently accepted specification by the Swiss Federal Office for Spatial Development (ARE) is based on an outdated standard from 1993.
Multiple cantons have since made adjustments to the methods to cater to their specific needs.
The varied alterations show that there is a need to create a general solution for Switzerland.
The cantonal adjustments and the current specification use linear distance for coverage radii and do not incorporate topographic data into the calculation.

This thesis introduces a new uniform specification for public transport quality gradings ("ÖV-Güteklassen 2018") which incorporates the varied approaches from the cantons and combines them with more modern technical capabilities.
The specification requires the coverage areas to be calculated along a pedestrian routing graph that incorporates topography of the area as well as the frequency of service.

Additionally, we created a software that implements the newly designed specification.
With the help of the routing engine "pgRouting", we create coverage areas along a pedestrian routing graph that allows for a more detailed understanding of the public transport coverage radius.
A high-resolution digital height model from Swisstopo integrates the topography into this radius allowing a public transport stop on a steep hill to show a smaller area of coverage.
Furthermore, we define a new formula to calculate the time intervals of public transport stations and incorporate that into our quality measurement.

In order to evaluate the effectiveness  of the calculation for the new specification, we created a web application which allows the new coverage areas to be examined and compared with the current public transport gradings from ARE.
This web application allows for analysis of the differences between the two specifications and emphasizes the greater accuracy of the proposed new specification to form a unified public transit quality grading throughout the country.

The project is available under <https://github.com/public-transport-quality-grades/>