<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> id="title" -->
# Reveal-Skel
## A template for Reveal.js-based presentations

[![Build status](https://github.com/sermons/reveal-skel/actions/workflows/build.yml/badge.svg)](https://github.com/sermons/reveal-skel/actions/workflows/build.yml)
![Dependency check](https://img.shields.io/librariesio/github/sermons/reveal-skel)
<br>
[(open master view)](http://reveal-skel.seanho.com/?s=45ba034647cea150 "ref")

[Ryan Hutton](https://unsplash.com/photos/Jztmx9yqjBw "caption")

>>>
+ Speaker notes go here.
+ **Markdown** is supported.

______

Six underscores create a horizontal rule in the notes

---
<!-- .slide: data-background="white" -->
# Opening <br> **Question**
<!-- .element: class="r-fit-text" -->

---
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> id="outline" class="outline" -->
## Outline [大綱](# "zh")
1. Point **One** [(ref)](# "ref")
1. Point *Two* 
1. Point *Three* 

`$$ \hat{f}(\omega) = \int_{-\infty}^\infty f(x)e^{-2\pi x \omega} \,dx $$`

******
<!-- six stars create a vertical slide -->
## Code Block

```
class BST:
  def __init__(self):
    self.root = None

  def search(self, key): # iterative search
    cur = self.root
    while (cur != None):
      if key &lt; cur.key: cur = cur.left
      else if key &gt; cur.key: cur = cur.right
      else: return cur
```

---
## Flexbox Layout

<!-- HTML in separate paragraph -->
<div class="imgbox"><div>

+ **Multi-col** layout!
+ 1/3 width for text
+ `imgbox` div

</div>
<div style="flex:2">

![Stars](https://sermons.seanho.com/img/bg/unsplash-Jztmx9yqjBw-stars.jpg)

</div></div>

---
## Markdown Table

| ID |     Date    | Intensity | Diffusion |
|---:|:-----------:|----------:|----------:|
| 23 | 2017 Jan  3 |    17.3   |   0.238   |
| 83 | 2017 Feb  5 |    87.2   |   0.022   |
| 39 | 2017 Mar  1 |   219.0   |   0.912   |
| 12 | 2017 Apr  2 |     5.2   |   0.465   |
| 65 | 2017 May  2 |  1022.6   |   0.663   |

---
<!-- .slide: <%= bg("unsplash-Jztmx9yqjBw-stars.jpg") %> class="empty" -->
