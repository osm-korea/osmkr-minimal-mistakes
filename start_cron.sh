#!/bin/bash
export GEM_HOME="$HOME/.gems"
export PATH="$HOME/.local/bin:$HOME/.gems/bin:$PATH"

/home/ubuntu/.gems/bin/bundle exec jekyll serve > ../nohup.out &
