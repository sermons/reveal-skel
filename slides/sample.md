<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> id="title" -->
# Reveal-Skel
## A template for Reveal.js-based presentations

<div>
[![Travis builds](https://travis-ci.org/sermons/reveal-skel.svg)](https://travis-ci.org/sermons/reveal-skel)
[![Node deps](https://david-dm.org/sermons/reveal-skel.svg)](https://david-dm.org/sermons/reveal-skel)
[![Node devDeps](https://david-dm.org/sermons/reveal-skel/dev-status.svg)](https://david-dm.org/sermons/reveal-skel?type=dev)
</div>

[(open master view)](http://reveal-skel.seanho.com/?s=45ba034647cea150 "ref")

[(img: Ryan Hutton, CC0)](https://unsplash.com/photos/Jztmx9yqjBw "caption")

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
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> id="outline" -->
## Outline [(ref)](# "ref")
1. Point **One** <%= bible('(Rom 1:1,5)') %>
2. Point **Two** <%= bible('rom1.2', '(v2)') %>
3. Point **Three** <%= bible('rom1.3-4', '(v3-4)', 'ESV') %>

<!-- .element: class="outline" comment="need previous blank line!" -->

******
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

******
<!-- .slide: data-background="white" -->
# Review question for Point **One**

---
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> -->
## Outline <span class="zh">大綱</span>
1. Point *One* <span class="ref">(v1)</span>
2. **Point Two** <span class="ref">(v2)</span>
3. Point *Three* <span class="ref">(v3)</span>
  + A bit of math: <br>
    \` hat(f)(omega) = int\_-oo^oo f(x)e^(-2pi x omega) dx \`

<!-- .element: class="outline" -->

******
## Point Two

<div class="imgbox">
<div>
Yay for **multi-col** layout! <br/>
1/3 width for text <br/>
No block-level markdown
</div>
<div style="flex:2">
![Stars](static/bg/unsplash-Jztmx9yqjBw-stars.jpg)
<div class="caption">
(img credit: Ryan Hutton)
</div>
</div>
</div>

******
<!-- .slide: data-background="white" -->
# Review question for Point **Two**

---
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> -->
## Outline
1. Point *One* <span class="ref">(v1)</span>
2. Point *Two* <span class="ref">(v2)</span>
3. **Point Three** <span class="ref">(v3)</span>

<!-- .element: class="outline" -->

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
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> -->
## Outline
1. Point **One** <span class="ref">(v1)</span>
2. Point **Two** <span class="ref">(v2)</span>
3. Point **Three** <span class="ref">(v3)</span>

<!-- .element: class="outline" -->

---
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> class="empty" -->
