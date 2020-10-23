#!/bin/bash
# ##################################################
# BASH script useful to prepare the lambda package to be deployed as FaaS
#

scriptTemplateVersion="1.0.0" # Version of lambda_pkg that this script is based on
#                               v.1.0.0 - initial version
#
# HISTORY:
#
# * March,16 2020 - v1.0.0  - First Creation
#
# ##################################################
set -o errexit

# Source Scripting Utilities
# -----------------------------------
# This bash provides a script to install dependencies required which will 
# be used in lambdas function, packages source codes and make a .zip to
# be deployed on the infraestructure.
# -----------------------------------
cd $path_cwd


echo "**************************"
echo "Starting "
echo "**************************"

############## Main functionality ###################
#####################################################

rm -Rf $lambda_output_path/*

#Install dependency to package source code together dependency
sudo pip install virtualenv

#virtual env setup
cd $path_module
virtualenv -p $python_runtime env-$lambda_name
source env-$lambda_name/bin/activate

#installing python dependencies
requeriments_file=$lambda_resource_code_path/python_requirements.txt
if [ -f $requeriments_file ]; then
  pip install -r $requeriments_file
fi
deactivate

#creating deployment package
cd env-$lambda_name/lib/$python_runtime/dist-packages/

cp -r ./jen* $path_cwd/$lambda_output_path
cp -r $path_cwd/$lambda_source_code_path/* $path_cwd/$lambda_output_path

#removing temporary folder
sudo rm -Rf $path_module/env-$lambda_name/

echo "**************************"
echo "End process "
echo "**************************"