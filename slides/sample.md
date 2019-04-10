<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> id="title" -->
# Reveal-Skel
## A template for Reveal.js-based presentations

[![Travis builds](https://travis-ci.org/sermons/reveal-skel.svg)](https://travis-ci.org/sermons/reveal-skel)
[![Node deps](https://david-dm.org/sermons/reveal-skel.svg)](https://david-dm.org/sermons/reveal-skel)
[![Node devDeps](https://david-dm.org/sermons/reveal-skel/dev-status.svg)](https://david-dm.org/sermons/reveal-skel?type=dev)

[(open master view)](http://reveal-skel.seanho.com/?s=45ba034647cea150 "ref")

[Ryan Hutton](https://unsplash.com/photos/Jztmx9yqjBw "caption")

>>>
+ Speaker notes go here.
+ Markdown is supported.

______

Six underscores create a horizontal rule in the notes

---
<!-- .slide: data-background="white" -->
# Opening **Question**

[###](#/outline "secret")

---
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> id="outline" class="outline" -->
## Outline [(ref)](# "ref")
1. Point **One** <%= bible('(Rom 1:1,5)') %>
2. Point **Two** <%= bible('rom1.2', '(v2)') %>
3. Point **Three** <%= bible('rom1.3-4', '(v3-4)', 'ESV') %>

******
<!-- six stars create a vertical slide -->
## Point One
```
class BSTNode:
  def __init__(self, key=None,
      par=None, left=None, right=None):
    (self.key, self.par) = (key, par)
    (self.left, self.right) = (left, right)

class BST:
  def __init__(self):
    self.root = None

  def search(self, key):      # iterative search
    cur = self.root
    while (cur != None):
      if key &lt; cur.key:        # go left
        cur = cur.left
      else if key &gt; cur.key:   # go right
        cur = cur.right
      else:               # found it!
        return cur
```
<!-- .element: data-line-numbers="14-17" -->

******
<!-- .slide: data-background="white" -->
# Review question for Point **One**

---
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> class="outline" -->
## Outline <span class="zh">大綱</span>
1. Point *One* [(v1)](# "ref")
2. **Point Two** [(v2)](# "ref")
3. Point *Three* [(v3)](# "ref")
  + A bit of math: <br>
    \` hat(f)(omega) = int\_-oo^oo f(x)e^(-2pi x omega) dx \`

******
## Point Two

<!-- HTML in separate paragraph -->
<div class="imgbox"><div>

+ **Multi-col** layout!
+ 1/3 width for text
+ `imgbox` div

</div>
<div style="flex:2">

![Stars](https://sermons.seanho.com/img/bg/unsplash-Jztmx9yqjBw-stars.jpg)

</div></div>

******
<!-- .slide: data-background="white" -->
# Review question for Point **Two**

---
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> class="outline" -->
## Outline
1. Point *One* [(v1)](# "ref")
2. Point *Two* [(v2)](# "ref")
3. **Point Three** [(v3)](# "ref")

******
## Point Three

| ID |     Date    | Intensity | Diffusion |
|---:|:-----------:|----------:|----------:|
| 23 | 2017 Jan  3 |    17.3   |   0.238   |
| 83 | 2017 Feb  5 |    87.2   |   0.022   |
| 39 | 2017 Mar  1 |   219.0   |   0.912   |
| 12 | 2017 Apr  2 |     5.2   |   0.465   |
| 65 | 2017 May  2 |  1022.6   |   0.663   |

******
<!-- .slide: data-background="white" -->
# Review question for Point **Three**

---
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> class="outline" -->
## Outline
1. Point **One** [(v1)](# "ref")
2. Point **Two** [(v2)](# "ref")
3. Point **Three** [(v3)](# "ref")

---
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> class="empty" -->
