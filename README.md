# Project: Can you recognize the emotion from an image of a face? 
<img src="figs/CE.jpg" alt="Compound Emotions" width="500"/>
(Image source: https://www.pnas.org/content/111/15/E1454)

### [Full Project Description](doc/project3_desc.md)

Hi class, in this project, we carried out model evaluation and selection for predictive analytics on image data. As data scientists, we often need to evaluate different modeling/analysis strategies and decide what is the best. Such decisions need to be supported by sound evidence in the form of model assessment, validation and comparison. Because of this we used 3 different models to compare each analysis. Each one had a different efficiency. We had to walk the fine line of complexity vs efficiency in this project. In addition, we also need to communicate our decision and supporting evidence clearly and convincingly in an accessible fashion. Here is our repository organized for reproducibility and ease of understanding.

Term: Spring 2021

+ Team 6
+ Team members
	+ Weiwei Song
	+ Changhao He
	+ Aurore Gosmant
	+ Zi Fang
	+ Jimmy Smiley

+ Project summary: In this project, we created a classification engine for facial emotion recognition.
  +  78 fiducials points of each emotion are marked in order for analysis. 
  + Distributions of vertical distance between right pupil(1) and  right brow peak(21) are shown in  histograms. For example, the distance of an angry face tends to be shorter than that of a surprised face.
  + The distributions of vertical distances between right mouth corner(50)
and the midpoint of the upper lip(52).  For example, the distance of an happy face tends to be shorter than that of a sad face.
	
**Contribution statement**: ([default](doc/a_note_on_contributions.md)) 

Weiwei Song: implement the XGBoost, XGBoost+SMOTE,  and Random Forest algorithms, and write the related .Rmd and R script files.  preparing the presentation slices

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
