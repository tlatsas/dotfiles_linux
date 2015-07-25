#!/usr/bin/env python

import subprocess
import random

from os import listdir
from os.path import abspath, expanduser, isfile, join


wallpapers_dir = abspath(expanduser('~/themes/wallpapers/hires'))
wallpapers = [ f for f in listdir(wallpapers_dir) if isfile(join(wallpapers_dir, f)) ]

cmd = ['nitrogen', '--save', '--set-zoom-fill']
cmd.append(join(wallpapers_dir, random.choice(wallpapers)))

subprocess.call(cmd)
