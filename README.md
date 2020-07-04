# Image Analysis Project using R
Image Analyzing Project using R and HADOOP. Made by: Valerie Verhalle, Sanne Schröduer and Janne Knuiman

See also our other repository: Image Analysis Python Project (https://github.com/JanneKnuiman/ImageAnalysisPyhton)

Start date: 20-04-2020

## Installation of the required modules
System requirements:

| Module        | Version       |
| ------------- | ------------- |
| Hadoop        | 2.6.5         |
| R or RStudio  | 3.2.3         |

Run ```RunFirst.R``` in R or RStudioto set system variables for Hadoop and install R libraries

## Usage of the Species Count
Run ```SpeciesCount.R``` in R or RStudio to calculate the different species in the Iris dataset.

## Image Classifier
System requirements:

| Module        | Version       |
| ------------- | ------------- |
| Tensorflow    | 2.1.0         |
| Keras         | 1.0.8         |
| R or RStudio  | 3.5.1         |

Run ```ImageClassifier.R``` in R or RStudio to classify images using a Sequential model into a category: cat or dog. 
The input data is downloaded from: https://storage.googleapis.com/mledu-datasets/cats_and_dogs_filtered.zip
