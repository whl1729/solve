# Q215 自动驾驶仿真领域有哪些优秀的开源项目

## 版本说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2024-06-26 | 1.1 | 参考 Choose Your Simulator Wisely 论文来梳理项目 |
| 2024-06-25 | 1.0 | 初稿 |

## 解答

根据 [Choose Your Simulator Wisely][8]，自动驾驶仿真可以分为五个领域：

- 集成仿真
- 交通流仿真
- 传感器数据仿真
- 汽车动力学仿真
- 驾驶政策仿真

下面按照每个领域来给出对应的开源项目：

- 集成仿真
  - [CARLA][5]
  - [Apollo][2]
  - [DeepDrive][9]
  - [Vista][10]
  - [Open Sim-One][3]
- 交通流仿真
  - [SUMO][11]
  - [Flow][12]
  - [CityFlow][13]
- 传感器数据仿真
  - [AirSim][7]
  - [SVL][14]
- 汽车动力学仿真
  - [Webots][15]
  - [Gazebo][16]
- 驾驶政策仿真

## 参考资料

- [2024年自动驾驶仿真产业研究报告][1]
- [汽车自动驾驶仿真测试蓝皮书][6]
- [Choose Your Simulator Wisely: A Review on Open-source Simulators for Autonomous Driving][8]

  [1]: https://db.shujubang.com/home/login/index/gid/20753
  [2]: https://apollo.baidu.com/
  [3]: https://gitee.com/OpenSimOne
  [5]: https://carla.org/
  [6]: https://yd.qq.com/web/bookDetail/dc8325a0721639fbdc8aadc
  [7]: https://github.com/microsoft/AirSim
  [8]: https://arxiv.org/abs/2311.11056
  [9]: https://github.com/deepdrive/deepdrive
  [10]: https://github.com/vista-simulator/vista
  [11]: https://github.com/eclipse-sumo/sumo
  [12]: https://flow-project.github.io/index.html
  [13]: https://cityflow-project.github.io/
  [14]: https://github.com/lgsvl/simulator
  [15]: https://github.com/cyberbotics/webots
  [16]: https://gazebosim.org/home
