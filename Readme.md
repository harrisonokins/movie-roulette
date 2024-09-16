# IMDB Movie Roulette
This is a basic Ruby script that randomly chooses a feature film from IMDB's catalogue.

# Installation
1. Make sure `rbenv` is installed: https://github.com/rbenv/rbenv#using-package-managers
   1. Install ruby: `rbenv install 3.0.4`
   2. Initialize `rbenv`: `rbenv init` (this can also be exported to your ZSH shell by running `echo 'eval "$(~/.rbenv/bin/rbenv init - zsh)"' >> ~/.zshrc`)
   3. Set your working directory to use the just-installed Ruby version: `rbenv local 3.0.4`
2. Make sure `bundler` is installed: `gem install bundler`
3. Install all dependencies: `bundle install`
4. Start the server: `ruby movietime.rb`
5. Visit http://127.0.0.1:4567/movie in your browser
6. Viola! A wild movie appears!
