#!/bin/bash
	/bin/rm -rf /docroot/.git
	/bin/rm -rf /docroot/*.html
	
	/usr/bin/git clone https://github.com/puppetlabs/exercise-webpage.git /docroot/
