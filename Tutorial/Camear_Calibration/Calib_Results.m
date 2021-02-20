% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 469.419168839636711 ; 468.282656155384018 ];

%-- Principal point:
cc = [ 311.687668858908978 ; 180.667126746145811 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.128930011493223 ; -0.205388549278893 ; -0.004040629007466 ; -0.006025958292235 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 17.175703415015981 ; 15.502661229935571 ];

%-- Principal point uncertainty:
cc_error = [ 4.824983804488880 ; 9.767466377152710 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.026638975901344 ; 0.121627880349441 ; 0.003294988825554 ; 0.004310534715927 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 360;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 3;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.049036e+00 ; 2.084084e+00 ; -4.499566e-01 ];
Tc_1  = [ -2.488653e+02 ; -2.049264e+02 ; 1.640662e+03 ];
omc_error_1 = [ 6.130284e-03 ; 8.342171e-03 ; 1.700820e-02 ];
Tc_error_1  = [ 1.675656e+01 ; 3.340218e+01 ; 5.808374e+01 ];

%-- Image #2:
omc_2 = [ 1.947514e+00 ; 2.029177e+00 ; -9.720118e-02 ];
Tc_2  = [ -1.702851e+02 ; -2.252922e+02 ; 1.550454e+03 ];
omc_error_2 = [ 1.144058e-02 ; 8.650762e-03 ; 1.244516e-02 ];
Tc_error_2  = [ 1.602121e+01 ; 3.160721e+01 ; 5.455978e+01 ];

%-- Image #3:
omc_3 = [ 1.958635e+00 ; 2.088256e+00 ; -5.788827e-02 ];
Tc_3  = [ -3.462938e+02 ; -2.115662e+02 ; 1.653503e+03 ];
omc_error_3 = [ 1.119805e-02 ; 8.759723e-03 ; 1.167343e-02 ];
Tc_error_3  = [ 1.724840e+01 ; 3.385304e+01 ; 5.754395e+01 ];

