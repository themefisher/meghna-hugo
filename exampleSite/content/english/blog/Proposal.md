---
title: "Project Proposal"
date: 2021-02-25
image_webp: images/blog/proposal.webp
image: images/blog/proposal.png
description : "Proposal"
toc: true
---

## Introduction





## Objective
This project aims to utilise various R packages to build an **interactive R Shiny application** that serves as an integrated platform which allows users to perform the following analysis:

1.	Text Analysis 

2.	Exploratory and Confirmatory Data Analysis 

3.	Predictive Analytics 



## Use case
1. Hosts: In 2014, Airbnb launched the Superhost programme to reward hosts with outstanding hospitality. As a Superhost, one will have better earnings, more visibility, and are able to earn exclusive rewards such as increased earnings compared to regular hosts. To become a Superhost, these are the criteria to be met: 

-	4.8 or higher overall rating based on reviews 

-	Completed at least 10 stays in the past year or 100 nights over at least 3 completed stays 

-	Less than 1% cancellation rate, not including extenuating circumstances 

-	Responds to 90% of new messages within 24 hours.
 
2.	Guests: With over 60,000 members and 6000 properties listed on Airbnb website, a dilemma on which is the right space might be of concern to users. 

Hence, this dashboard allows users to analyse their needs and compare across other listings.


## Data

Dataset used is obtained from [Inside Airbnb](http://insideairbnb.com/singapore/). In particular, we extracted the following files: 
-	listing.csv.gz: This dataset consists of 74 variables and 4256 data points. 
-	Reviews.csv.gz: This dataset provides 6 variables and 52368 data points. 

The location is Singapore, with latest date compiled on 27 January 2021.


## Proposed Analytical Methods and Visualisation

### Map

To show the **distribution of listings** in Singapore. The intensity of colour can be used to highlight price range, superhost, room type, etc.	

**Application snapshot**
![](/images/blog/proposal/fig1.png) |


### Word Cloud

To explore the **frequency** of textual data of reviews and listings. This allows users to identify the words that are **most commonly associated** (proportionate to size) with a particular listing / neighbourhood, etc. 

**Application snapshot**
![](/images/blog/proposal/fig2.png) 

### Sentiment
To identify **positive and negative** words associated with the listings, cloud comparison is used.	

**Application snapshot**
![](/images/blog/proposal/fig3.png) 


### Exploratory Data Analysis

To explore the Airbnb dataset and identify **interesting trends** with the interactive visualization. 

**Application snapshot**

![](/images/blog/proposal/fig4.png)

### Confirmatory Data Analysis
To **perform statistical test** on listings data to augment findings found in the “Exploratory” tab. 

**Application snapshot**

![](/images/blog/proposal/fig5.png)

### Distribution of variables
To have better understanding of the variables and their potential to be a predictor of a response variable (price/rating), predictive analysis with different model types can be done.

**Application snapshot**

![](/images/blog/proposal/fig6.png)

### Correlation matrix
To visualise the relationships between the independent variables and check for signs of multi-collinearity among the independent variables. Highly correlated variables to be excluded from the model.

**Application snapshot**

![](/images/blog/proposal/fig7.png)
	 
### Multiplot
To check for any signs for complete and/or quasi-complete separation, which must be excluded from the predictive model as they will prevent the convergence of the maximum likelihood estimates for the coefficient and ultimately distorting the model.

**Application snapshot**

![](/images/blog/proposal/fig8.png)

### Data splitting and sampling
To partition the data into training/test/validation sets and apply selected cross validation.

Note: Percentage of target must be proportionate across the different dataset.	 

**Application snapshot**

![](/images/blog/proposal/fig9.png)

### Model calibration
To select calibrate different classification and regression models.
	 
**Application snapshot**

![](/images/blog/proposal/fig10.png)

### Model evaluation
To select assessment method for model, compute confusion matrix and display variable importance of selected model.	 

**Application snapshot**

![](/images/blog/proposal/fig11.png)


## Proposed R Packages
|Packages | Purpose | 
| ------- | ------- | 
| [Tidyverse](https://www.tidyverse.org/) | For data manipulation | 
| [cld3](https://github.com/google/cld3) | To filter out non-English observations| 
| [Tidytext](https://www.tidytextmining.com/) | For processing textual data |
| [wordcloud](https://www.rdocumentation.org/packages/wordcloud/versions/2.6/topics/wordcloud) |	To create word cloud | 
| [Plotly](https://plotly.com/) | Create interactive plots for exploratory analysis |
| [ggstatsplot](https://indrajeetpatil.github.io/ggstatsplot/index.html) |	Create plots with statistical tests included within plot |
| [Tidymodels](https://www.tidymodels.org/) | Build prediction models  |
