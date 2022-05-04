* This is an example code for the algorithm described in

J. Zhao, J. Ma, J. Tian, J. Ma, and D. Zhang. "A robust method for vector field learning with application to mismatch removing", CVPR 2011.

* To run the example code: 

1. Download and unpack the image dataset of Mikolajczyk from "http://www.robots.ox.ac.uk/
  ~vgg/research/affine/index.html",and put the images and homography files in the 
  "image&homography" directory and rename the homography file as this form: "bikes_H1to2p".

2. Download and unpack vlfeat-0.9.9.tar.gz (or later version) from http://www.vlfeat.org/", 
  and put it in the root directory. Installing requires including VLFeat in MATLAB search 
  path, which can be done at run-time by the command vl_setup('noprefix') found in 
  vlfeat/tooblox/.

3. Download and unpack Matlab Vector Field Visualization toolkit from "http://sccn.ucsd.edu/
  ~nima/downloads/vfv1.01.zip", and put all files in it in the "VectorFieldTools" dictionary.

4. Run demos contained in the root directory.