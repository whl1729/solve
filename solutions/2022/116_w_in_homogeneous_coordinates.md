# Q116 如何理解齐次坐标中 w 分量的几何意义？

## 版本说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2022-01-15 | 1.0 | 初稿 |

## 题目

这个问题是琦神举行的 「WebGL 培训第7课」的思考题目，原题目如下所述：

今天我们讲到了从 Clipping space 转换到 NDC space 的时候，会对齐次坐标 [x, y, z, w] 的每个分量除以 w。
然而，w 是很可能出现0值的。当 w = 0 时，这个除法显然是无法进行的。

1. w = 0 的几何意义是什么？或者说，什么情况下 w = 0 ？
2. 如何处理 w = 0 的情况？

这里说的是一个点(vertex)变换到 Clipping space 之后，出现 w = 0 的情况。
变换前 w = 1，经过 MVP 矩阵变换后 w = 0。

## 解答

### 思路

- 理解为什么引入齐次坐标
- 理解投影是什么
- 理解如何用矩阵来实现投影
- 理解 w 的含义

### 为什么引入齐次坐标

根据《OpenGL Programming Guide》Chapter 5 里面对「Homogeneous Coordinates」的描述（如下所示），
齐次坐标的引入可以解决两个问题：一是可以实现投影，二是可以通过线性变换来实现平移。

> we will gain two key advantages by moving from three-component Cartesian coordinates to four-component homogeneous coordinates.
> These are (1) the ability to apply perspective and (2) the ability to translate (move) the model using only a linear transform.
> That is, we will be able to get all the rotations, translations, scaling, and projective transformations we need by doing matrix multiplication if we first move to a four-coordinate system.
>
> 备注：线性变换满足以下条件：`T(a * x + b * y) = a * T(x) + b * T(y)`

用自己的话来解释一下吧。

#### 矩阵乘法的好处

首先，我们希望通过「矩阵乘法」来实现全部旋转、放缩、平移和投影等操作。
为什么是「矩阵乘法」呢？比如说，为什么不能是「矩阵加法」呢？
因为，矩阵与向量在维度不同的时候无法相加，并且旋转和放缩这些操作明显不能通过加法来实现。
而且，使用「矩阵乘法」还有个好处：
将多个操作对应的矩阵相乘，得到一个新矩阵，这个新矩阵就能表达多个操作的综合结果。特别方便。

#### 三维坐标的局限性

然后，我们会发现：三维坐标下，通过矩阵乘法可以实现旋转和放缩，但无法实现平移和投影。

平移比较好理解。通过观察原点就能发现问题：
平移意味着原点被映射到至少有一个维度的坐标不为0的点，而任何三维矩阵乘以原点，结果依然是原点。

投影呢？
我们先来看看投影究竟是怎么一回事：
投影首先是将「三维坐标」映射到「二维坐标」。

既然如此，那么最简单的投影方式是直接将第三个坐标 z 去掉。这其实便是「正交投影」。
正交投影的特点是不管物体距离远近，投影后的大小都相同。

而我们摄影时显然不是这样的，而是：近大远小。这便是「中心投影」的主要特点。
所以，中心投影有点类似于放缩——它会将 x 和 y 进行放缩，放缩倍数跟 z 成比例。

试想，我们能在三维坐标下实现中心投影吗？
这意味着我们要通过矩阵乘法实现两个坐标的除法（如`x/z`），显然是无法做到的。

事实上，我觉得四维坐标下，同样没法通过矩阵乘法来实现中心投影。
矩阵乘法永远无法实现两个坐标的除法。

是的，单靠矩阵乘法是无法实现中心投影的，需要引入「齐次坐标」的概念，
并且让第四维度的坐标 w 来反映距离，
然后前面三个维度的坐标分别除以这个 w，就能实现「近大远小」的效果了。

### 理解 w 的含义

#### w 反映物体与照相机的距离

根据《OpenGL Programming Guide》的以下描述，可以知道：w 其实是反映物体与照相机之间的距离。

> Perspective transforms modify w components to values other than 1.0.
> Making w larger can make coordinates appear further away.
> When it’s time to display geometry, OpenGL will transform homogeneous coordinates back to the three-dimensional Cartesian coordinates by dividing their first three components by the last component.
> This will make the objects farther away (now having a larger w) have smaller Cartesian coordinates, hence getting drawn on a smaller scale.
> A w of 0.0 implies (x, y) coordinates at infinity (the object got so close to the viewpoint that its perspective view got infinitely large). This can lead to undefined results.

#### w 的取值变化

在大多数变换中，比如旋转、放缩和平移等，w 的取值不会发生改变，保留为1.

而在投影变换中，w 的取值将会发生改变，通常不再为1.
事实上，投影变换后，w 的取值正是 z 坐标的大小。而 z 坐标的范围为[n, f]。n 和 f 分别代表 near plane 和 far plane 的距离。

现在，我们可以回答 WebGL 第7节课的问题了。

### 回答问题

1. w = 0 的几何意义是模型（或者说物体）与相机的距离为0，或者说物体就在观察点所在平面上。
2. 对 w = 0 的处理方法：落在观察点所在平面的点，也就是不落在平截头体范围内，直接去掉就可以了？

## 参考资料

1. OpenGL Programming Guide
2. Real-Time Rendering
