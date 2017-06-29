<!-- .slide: data-background-image="static/bg/unsplash-Jztmx9yqjBw-stars.jpg" data-state="title" -->
# Reveal-Skel
## A template for Reveal.js-based presentations

<div class="imgbox"><div>
[![Travis-CI build status](https://travis-ci.org/sermons/reveal-skel.svg)](https://travis-ci.org/sermons/reveal-skel)
[![Node dependencies](https://david-dm.org/sermons/reveal-skel.svg)](https://david-dm.org/sermons/reveal-skel)
[![Node dev status](https://david-dm.org/sermons/reveal-skel/dev-status.svg)](https://david-dm.org/sermons/reveal-skel#info=devDependencies)
</div></div>

<div class="ref">
[(open master view)](http://reveal-skel.seanho.com/?s=45ba034647cea150)
</div>

>>>
+ Speaker notes go here.
+ Markdown is supported.

______

Six underscores create a horizontal rule in the notes

---
<!-- .slide: data-background="white" -->
# Opening **Question**

[###](#/outline)
<!-- .element: style="color:rgba(0,0,0,0.2)" -->

---
<!-- .slide: data-background-image="static/bg/unsplash-Jztmx9yqjBw-stars.jpg" id="outline" -->
## Outline <span class="zh">大綱</span>
1. Point **One** <span class="ref">(v1)</span>
2. Point **Two** <span class="ref">(v2)</span>
3. Point **Three** <span class="ref">(v3)</span>
  + A bit of math: \` hat(f)(omega) = int\_-oo^oo f(x)e^(-2pi x omega) dx \`

---
## Point One
```
class BSTNode:
  def __init__( self, key=None, par=None, left=None, right=None ):
    ( self.key, self.par, self.left, self.right ) = ( key, par, left, right )

class BST:
  def __init__( self ):
    self.root = None

  def search( self, key ):      # iterative search
    cur = self.root
    while (cur != None):
      if key < cur.key:         # go left
        cur = cur.left
      else if key > cur.key:    # go right
        cur = cur.right
      else:                     # found it!
        return cur
```

---
<!-- .slide: data-background="white" -->
# Review question for Point **One**

---
<!-- .slide: data-background-image="static/bg/unsplash-Jztmx9yqjBw-stars.jpg" -->
## Outline
1. Point *One* <span class="ref">(v1)</span>
2. **Point Two** <span class="ref">(v2)</span>
3. Point *Three* <span class="ref">(v3)</span>

---
## Point Two

<div class="imgbox">
<div>
Yay for multi-column layouts!

One-third width for text.

Within the HTML div, Markdown **bold** is ok, but not lists.
</div>
<div style="flex:2; -webkit-box-flex:0.5">
![Stars](static/bg/unsplash-Jztmx9yqjBw-stars.jpg)
</div>
</div>

---
<!-- .slide: data-background="white" -->
# Review question for Point **Two**

---
<!-- .slide: data-background-image="static/bg/unsplash-Jztmx9yqjBw-stars.jpg" -->
## Outline
1. Point *One* <span class="ref">(v1)</span>
2. Point *Two* <span class="ref">(v2)</span>
3. **Point Three** <span class="ref">(v3)</span>

---
## Point Three

| ID |     Date    | Intensity | Diffusion |
|---:|:-----------:|----------:|----------:|
| 23 | 2017 Jan  3 |    17.3   |   0.238   |
| 83 | 2017 Feb  5 |    87.2   |   0.022   |
| 39 | 2017 Mar  1 |   219.0   |   0.912   |
| 12 | 2017 Apr  2 |     5.2   |   0.465   |
| 65 | 2017 May  2 |  1022.6   |   0.663   |

---
<!-- .slide: data-background="white" -->
# Review question for Point **Three**

---
<!-- .slide: data-background-image="static/bg/unsplash-Jztmx9yqjBw-stars.jpg" -->
## Outline
1. Point **One** <span class="ref">(v1)</span>
2. Point **Two** <span class="ref">(v2)</span>
3. Point **Three** <span class="ref">(v3)</span>

---
<!-- .slide: data-background-image="static/bg/unsplash-Jztmx9yqjBw-stars.jpg" class="empty" -->
