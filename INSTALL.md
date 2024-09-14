# Installing [reveal-skel](https://github.com/sermons/reveal-skel)

## Intro
Reveal-skel is a forkable template for a presentation based on the [Reveal.js](http://lab.hakim.se/reveal-js/) HTML framework.

The Github Actions workflow in [build.yml](.github/workflows/build.yml) 
runs a [Node.js project](package.json), 
calling [Grunt tasks](Gruntfile.coffee) to
build [the presentation](template/index.html) as a website and
deploy it on Github Pages.

## Usage
* **Fork** the [reveal-skel](https://github.com/sermons/reveal-skel) project
  + Or in your own git repo, run `git remote add upstream https://github.com/sermons/reveal-skel`
+ In the Github settings for your forked repository, under 'Pages', set the 'Source' to 'Github Actions'.
  + This allows the [deploy-pages](https://github.com/actions/deploy-pages) action to deploy directly to Github Pages,
    without using a `gh-pages` branch.
* **Edit** [package.json](package.json):
  + Package name, git repo, CNAME
  + Change `sample.md` to `slides.md`
  + Generate a new **multiplex ID** [(see below)](#multiplex-remote-control)
* Your slide **content** goes in [slides/slides.md](slides/slides.md)
* You may also want to **customize**:
  + user name, email in [package.json](package.json)
    + `pretty_url` defaults to the CNAME if it exists
  + [README](README.md), [favicon](static/favicon.ico)
* Static **assets** (CSS, JS, images, etc) go in [`static`](static)
  + Grunt will copy this dir as-is to the root of the deployed site

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
