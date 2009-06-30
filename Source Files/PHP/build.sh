#!/bin/sh

PATH_2_XSLTPROC=/usr/bin/xsltproc
PATH_2_STYLESHEET=XSLT/bbedit_php_clipping_set.xsl
PATH_2_PHP_MANUAL=/Users/tedsr/manual.xml
PATH_2_CLIPPING_SET=../PHP.php
PATH_2_SUPPORT_FILES=$PATH_2_CLIPPING_SET/Support\ Files
PATH_2_CUSTOM_CLIPPINGS=CustomClippings
# transform set
$PATH_2_XSLTPROC --nonet --novalid \
				 --stringparam save 'true' --stringparam do_constants 'true' \
				 --stringparam output_dir '../' --stringparam style 'zend' \
				 $PATH_2_STYLESHEET $PATH_2_PHP_MANUAL

# copy control structures, snippets, etc. to their locations
cp -R "$PATH_2_CUSTOM_CLIPPINGS/" "$PATH_2_CLIPPING_SET/"

# set filetype and creator to bbedit to speed things up
find "$PATH_2_CLIPPING_SET" -type f -exec /Developer/Tools/SetFile -t "TEXT" -c "R*ch" {} \;

# copy support script to their locations
mkdir -p "$PATH_2_SUPPORT_FILES"
cp Support\ Applications/call\ date\ format\ dialog.scpt "$PATH_2_CLIPPING_SET/Functions"
cp Support\ Applications/call\ date\ format\ dialog.scpt "$PATH_2_CLIPPING_SET/Classes/Methods/DateTime"
cp -R Support\ Applications/Date\ Format\ Dialog/build/Release/Date\ Format\ Dialog.app "$PATH_2_SUPPORT_FILES/"

# remove .DS_Store files
find "$PATH_2_CLIPPING_SET" -name .DS_Store -ls -exec rm {} \;

# get some statistics
echo `find "$PATH_2_CLIPPING_SET" -type f | wc -l`

# zip up package for distribution
tar -czf "${PATH_2_CLIPPING_SET}.tar.gz" $PATH_2_CLIPPING_SET
