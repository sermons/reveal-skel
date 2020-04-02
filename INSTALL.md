# Installing [reveal-skel](https://github.com/sermons/reveal-skel)

## Intro
Reveal-skel is a forkable template for a presentation based on the [Reveal.js](http://lab.hakim.se/reveal-js/) HTML framework.

[Travis integration](.travis.yml) deploys to Github Pages via an [NPM script](package.json), calling a [Grunt task](Gruntfile.coffee) to copy the rendered site
into a subdir and push to the gh-pages branch.

## Usage
* **Fork** the [reveal-skel](https://github.com/sermons/reveal-skel) project
  + Or in your own git repo, run `git remote add upstream https://github.com/sermons/reveal-skel`
* Setup a **Github token** for Travis [(see below)](#github-token-for-travis)
* **Edit** [package.json](package.json):
  + Package name, git repo, cname/URL
  + Change `sample.md` to `slides.md`
  + Generate a new **multiplex ID** [(see below)](#multiplex-remote-control)
* Your slide **content** goes in [slides/slides.md](slides/slides.md)
* You may also want to **customize**:
  + user name, email in [package.json](package.json)
  + [README](README.md), [favicon](static/img/favicon.ico)
* Static **assets** (CSS, JS, images, etc) go in [`static`](static)
  + Grunt will copy this dir as-is to the deployed site

## Github token for Travis
+ **Connect** [Travis](https://travis-ci.org) to your Github account, if you haven't already
+ On Github, create an access token: *Settings* &rarr; *Developer Settings* &rarr; *Personal access tokens* &rarr; **Generate new token**
  + *Token description*: e.g., "Travis push to gh-pages"
  + *Select scopes*: check "**repo**"
  + Press the **Generate token** button at the bottom
+ Copy and **save** the token outside the repo:
  + `echo "github_key=...MY_GITHUB_TOKEN..." > ~/.travis-key.conf`
+ [Install](https://github.com/travis-ci/travis.rb#installation) the Travis **gem**
  + See note in the [travis-key script](travis-key) for details
+ Run `./travis-key` to [securely store the token in Travis](https://docs.travis-ci.com/user/encrypting-files/):
+ Commit, **push**, and check the [build log](https://travis-ci.org/) for errors

## Bot user for Travis deploy
If you don't want Travis to have full write-access 
to all your repos, you may want to create a 
**special user** just for pushing to the `gh-pages`
branch.  This is what I do:

+ Create a new Github **user** (a 'bot')
+ In the bot account, create an **access token** as above
  + **Save** the token out-of-repo in `~/.travis-key.conf`
+ In your main account, add the bot as a **collaborator** on your repo:
  + "*Settings*" &rarr; "*Collaborators &amp; teams*" &rarr; "*Collaborators*"
  + Give the bot **Write** access so it can push
  + Or: [add the bot to an organization](https://developer.github.com/guides/managing-deploy-keys/#machine-users)
+ **Prevent** the bot from pushing to master:
  + "*Settings*" &rarr; "*Branches*" &rarr; "*Protected branches*" &rarr; "*master*"
  + Check "*Protect this branch*" and "*Restrict who can push to this branch*"
  + Now the bot can **only** push to gh-pages
+ Run the **script** `./travis-key` in each repo

## Multiplex (remote-control)
Don't use the default multiplex socket ID in the template, or your presentation
can be controlled by anyone with the corresponding secret
key (which I've made public).  You could get random slide changes.

If you want to setup your own remote control, you'll need a multiplex
server.  You may use [mine](https://mp.seanho.com/)  (please let me know if you do), or just setup
[your own](https://github.com/seanho00/reveal-multiplex). on a VPS.

Get a [token](https://mp.seanho.com/token) from the multiplex server, and
put the socket ID in your `package.json`.
Run the master presentation by appending `/?s=00SECRET00` to your URL
(replacing `00SECRET00` with your secret key).

## References
+ [reveal-multiplex](https://github.com/seanho00/reveal-multiplex) Socket.io server
+ [generator-reveal](https://github.com/slara/generator-reveal) Yeoman script
+ [gist-reveal](https://github.com/ryanj/gist-reveal)
+ [Reveal.js](http://lab.hakim.se/reveal-js/)
