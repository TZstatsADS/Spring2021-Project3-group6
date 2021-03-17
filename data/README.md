# Project: Can you recognize the emotion from an image of a face?

### Data folder

The data directory contains data used in the analysis. This is treated as read only; in paricular the R/python files are never allowed to write to the files in here. Depending on the project, these might be csv files, a database, and the directory itself may have subdirectories.

Because the data files used to train our models are private, we are not allowed to publish them online. Please, contact one member of the team to get more information on it. However, here is a brief description of the data.


The data was containing 3000 images and 3000.mat files representing fiducial points. Our first task was to extract the fiducial points for each image, and then compute pairwise distance between fiducial points, as these points can work as feature for facial emotion recognition.  Therefore, we managed to compute a matrix of features containing 6007 features.

  + In the first column, 78 fiducials points of each emotion are marked in order. 
  + In the second column distributions of vertical distance between right pupil(1) and  right brow peak(21) are shown in  histograms. For example, the distance of an angry face tends to be shorter than that of a surprised face.
  + The third column is the distributions of vertical distances between right mouth corner(50)
and the midpoint of the upper lip(52).  For example, the distance of an happy face tends to be shorter than that of a sad face.



