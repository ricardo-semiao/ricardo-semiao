# armasonry

Adam's Ribs masonry - a packing algorithm for rectangles with discrete dimensions.

The algorithm is as follows:

1. Start with an empty grid, and a list of rectangles.
2. Find the first empty row, then column.
3. Randomly pick the rectangles that fit to its right, exactly or with more than 1 unit of space. If no image fit, mark as a 'hole'.
4. Repeat 2.-3. until all rectangles are placed.
5. Repeat 1.-4. severa times, and pick the one with: less holes, then less shared divides, then highest height diversity.


Build with:

```
pip install packages\armasonry
```
