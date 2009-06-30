#!/bin/sh

PATH_2_XSLTPROC=/usr/bin/xsltproc
PATH_2_STYLESHEET=XSLT/bbedit_php_clipping_set.xsl
PATH_2_PHP_MANUAL=/Users/tedsr/manual.xml
PATH_2_CLIPPING_SET=PHP.php
PATH_2_SUPPORT_FILES=$PATH_2_CLIPPING_SET/Support\ Files
PATH_2_CUSTOM_CLIPPINGS=CustomClippings
PATH_2_RELEASES_DIR="../../Clipping Sets"

# transform set
echo "generating set"
$PATH_2_XSLTPROC --nonet --novalid \
				 --stringparam save 'true' --stringparam do_constants 'true' \
				 --stringparam output_dir '.' --stringparam style 'zend' \
				 $PATH_2_STYLESHEET $PATH_2_PHP_MANUAL

# copy control structures, snippets, etc. to their locations
echo "copying custom clippings"
cp -R "$PATH_2_CUSTOM_CLIPPINGS/" $PATH_2_CLIPPING_SET/

# set filetype and creator to bbedit to speed things up
echo "setting file type and creator"
find "$PATH_2_CLIPPING_SET" -type f -exec /Developer/Tools/SetFile -t "TEXT" -c "R*ch" {} \;

# copy support script to their locations
echo "copying support scripts and apps"
mkdir -p "$PATH_2_SUPPORT_FILES"
cp Support\ Applications/call\ date\ format\ dialog.scpt "$PATH_2_CLIPPING_SET/Functions"
cp Support\ Applications/call\ date\ format\ dialog.scpt $PATH_2_CLIPPING_SET/Classes/Methods/DateTime
cp -R Support\ Applications/Date\ Format\ Dialog/build/Release/Date\ Format\ Dialog.app "$PATH_2_SUPPORT_FILES/"

# remove .DS_Store files
echo "removing .DS_Store"
find "$PATH_2_CLIPPING_SET" -name .DS_Store -ls -exec rm {} \;

# get some statistics
echo "getting statistics"
echo `find "$PATH_2_CLIPPING_SET" -type f | wc -l`

# zip up package for distribution
echo "tarring everything up"
tar -czf "$PATH_2_CLIPPING_SET.tar.gz" $PATH_2_CLIPPING_SET

# copy release version to releases directory
echo "copying release version to releases directory"
cp -R $PATH_2_CLIPPING_SET "$PATH_2_RELEASES_DIR/"

# clean up
echo "deleting temporary files"
rm -Rf $PATH_2_CLIPPING_SET
