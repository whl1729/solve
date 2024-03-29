# Q41 C++ 使用多继承有什么缺点吗？

## 修改说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2021-04-09 | 1.0.0 | 提出问题 |
| 2021-04-10 | 1.0.1 | 解答问题 |

## 解答

1. 参考[Inheritance — Multiple and Virtual Inheritance][inheritance]
2. 多继承可以提供灵活性。误用则可能导致代码规模增长快、代码复杂度高。

  [inheritance]: https://isocpp.org/wiki/faq/multiple-inheritance

### Some disciplines for using multiple inheritance

> M.I. rule of thumb #1: Use inheritance only if doing so will remove if / switch statements from the caller code.
> M.I. rule of thumb #2: Try especially hard to use ABCs(Abstract Base Class) when you use MI. This rule of thumb tends to push people toward inheritance-for-interface-substitutability.
> M.I. rule of thumb #3: Consider the "bridge" pattern or nested generalization as possible alternatives to multiple inheritance. (Wu: 假设现在有两个类b1和b2，基于它们构造出一个新类d，有3种方法：bridge pattern 是指d继承b1，并定义一个b2的成员；nested generalization指先继承b1，再继承b2；multiple inheritance 指同时继承b1和b2.）

> In particular, inheritance is not for code-reuse. You sometimes get a little code reuse via inheritance, but **the primary purpose for inheritance is dynamic binding, and that is for flexibility**. Composition is for code reuse, inheritance is for flexibility.

### multiple inheritance, bridge pattern and nested generalization

- bridge pattern
  - advantage: 代码规模增长慢
  - disadvantage: 粗粒度控制、无法消除一些无意义的搭配
- nested generalization
  - advantage: 细粒度控制、可以消除一些无意义的搭配
  - disadvantage: 代码规模增长快、没有基于b2的共同基类
- multiple inheritance:
  - advantage: 细粒度控制、可以消除一些无意义的搭配
  - disadvantage: 代码规模增长快

### Goodness criteria

- Grow Gracefully
- Low Code Bulk
- Fine Grained Control
- Static Detect Bad Combos
- Polymorphic on Both Sides
- Share Common Code
