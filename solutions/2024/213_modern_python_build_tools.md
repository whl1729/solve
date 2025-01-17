# Q213 Python 有哪些现代构建工具

## 版本说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2024-06-20 | 1.0 | 初稿，采用大语言模型的回答 |

## 解答

这个问题我使用 ChatGPT 3.5 和通义千问 2.5 来回答了，它们提到 setuptools、poetry、flit 和 hatch 等工具，并且都推荐 poetry 工具。有空可以学习一下。

### ChatGPT 3.5 的回答

问：Python 有哪些现代构建工具？请对比它们的优缺点、使用人数、受欢迎程度、用户友好度和兼容性等，最后请推荐你认为最好的 Python 构建工具。

答：

Python 社区有几种现代构建工具，每种工具都有其独特的优缺点、使用人数、受欢迎程度、用户友好度和兼容性。以下是一些常见的现代构建工具及其特点：

#### 1. setuptools

- **优点**：
  - Python 标准库中自带，广泛使用。
  - 成熟稳定，支持丰富的功能和插件。
  - 兼容性好，与大多数 Python 包兼容。
  
- **缺点**：
  - 配置较为繁琐，需要在 `setup.py` 文件中编写大量的详细配置。
  - 对于复杂的项目和依赖管理，可能需要额外的插件支持。
  
- **使用人数**：非常广泛，是许多 Python 项目的默认选择。
  
- **受欢迎程度**：非常高，是传统和稳定的选择。
  
- **用户友好度**：较高，但配置复杂度可能略高于一些现代化工具。
  
- **兼容性**：与大多数 Python 包和项目兼容良好。

#### 2. poetry

- **优点**：
  - 简化的依赖管理，一体化的解决方案。
  - 支持项目初始化、依赖解析和管理、打包发布等多种功能。
  - 使用 `pyproject.toml` 文件作为配置，简化了项目配置和管理流程。
  
- **缺点**：
  - 相对较新，可能还存在一些不稳定性和功能缺失。
  - 某些功能需要额外的插件或扩展支持。
  
- **使用人数**：增长迅速，特别是在新项目和社区中受到欢迎。
  
- **受欢迎程度**：正在快速提升，被认为是现代化和简化配置的良好选择。
  
- **用户友好度**：非常高，简化了依赖管理和打包发布流程。
  
- **兼容性**：与大多数 Python 包和项目兼容良好，但可能与一些传统的老项目存在一些兼容性问题。

#### 3. flit

- **优点**：
  - 简化的 Python 包发布工具，专注于纯 Python 包的管理和发布。
  - 使用 `pyproject.toml` 文件配置，简化了项目配置和管理。
  - 自动处理依赖关系，并提供了简单的命令行界面。
  
- **缺点**：
  - 不支持构建和管理包含 C 扩展模块的项目。
  - 功能相对较少，适合简单的纯 Python 项目。
  
- **使用人数**：较少，主要在一些小型或简单的项目中使用。
  
- **受欢迎程度**：相对较低，因为功能限制了其在复杂项目中的应用。
  
- **用户友好度**：对于简单的纯 Python 包管理非常友好。
  
- **兼容性**：主要适用于纯 Python 包，与大多数纯 Python 包兼容。

#### 4. hatch

- **优点**：
  - 简化的 Python 项目管理工具，支持快速创建和管理项目。
  - 集成了依赖管理、环境管理和打包发布等功能。
  - 提供简单的命令行界面，易于使用。
  
- **缺点**：
  - 功能相对较少，适合小型或简单的项目。
  - 对于复杂项目和高级需求可能支持不足。
  
- **使用人数**：相对较少，主要在寻求简单快速解决方案的开发者中使用。
  
- **受欢迎程度**：中等，适合初学者和快速原型开发。
  
- **用户友好度**：非常高，为快速创建和管理项目提供了便利。
  
- **兼容性**：与大多数 Python 包和项目兼容，但对于复杂的依赖管理可能需要额外配置。

#### 推荐

根据功能全面性、使用便捷性以及社区支持程度，我推荐使用 **Poetry** 作为最佳的 Python 构建工具。它提供了全面的依赖管理、项目初始化、打包发布等功能，并且使用 `pyproject.toml` 文件作为配置，简化了项目管理和配置的流程。Poetry 在现代 Python 开发中受到广泛欢迎，特别是对于需要管理复杂依赖和支持 C 扩展模块的项目来说，它提供了强大的支持和灵活性。

### 通义千问 2.5 的回答

在 Python 生态系统中，有几个现代的构建工具因其高效性和功能性而脱颖而出。下面我会对比一些流行的构建工具，包括它们的优缺点、使用人数、受欢迎程度、用户友好度和兼容性。请注意，这些评估可能会随时间变化，因为社区对不同工具的支持和偏好也在不断演变。

#### 1. Poetry

- **优点**：Poetry 是一个全面的包管理器，它不仅处理依赖关系解析，还负责构建和发布。它使用 TOML 格式来定义项目元数据和依赖，这使得配置文件更清晰易读。Poetry 在开发环境中自动创建虚拟环境，简化了设置过程。
- **缺点**：在某些情况下，Poetry 的依赖解析算法可能不如 pipenv 或 setuptools 精确。
- **使用人数/受欢迎程度**：Poetry 在 GitHub 上有超过 35k 的 stars，是 Python 社区中最受欢迎的构建工具之一。
- **用户友好度**：Poetry 的文档详尽，命令行界面直观，对于新用户非常友好。
- **兼容性**：与 Python 3.6+ 兼容。

#### 2. Hatch

- **优点**：Hatch 是一个轻量级的构建工具，专注于构建过程，支持 PEP 517 和 PEP 518。它易于集成到现有的项目中，特别是在那些已经使用 `pyproject.toml` 的项目中。
- **缺点**：功能相对有限，主要集中在构建上，不提供包管理和依赖解析。
- **使用人数/受欢迎程度**：Hatch 在 GitHub 上有约 5k 的 stars，是一个较新的工具，但正在逐渐获得关注。
- **用户友好度**：Hatch 的文档清晰，接口简洁，易于上手。
- **兼容性**：与 Python 3.6+ 兼容。

#### 3. Setuptools

- **优点**：Setuptools 是一个成熟的构建工具，提供了丰富的功能，包括自定义构建步骤。它与 Python 社区的许多现有项目兼容。
- **缺点**：配置文件 `setup.py` 可能会变得复杂和难以维护，尤其是当项目规模增大时。
- **使用人数/受欢迎程度**：作为 Python 包管理的“标准”，几乎每个 Python 开发者都熟悉 setuptools。
- **用户友好度**：对于初学者来说，setup.py 的结构可能不够直观。
- **兼容性**：与 Python 2 和 3 兼容，但在 Python 3 中表现更佳。

#### 推荐

选择最佳的 Python 构建工具主要取决于项目的特定需求。然而，基于上述分析，如果我必须推荐一个，我会倾向于 **Poetry**。Poetry 提供了一个现代的、用户友好的界面，同时处理依赖管理和构建，这使得它成为大多数 Python 项目的理想选择。它的流行度和社区支持也是强有力的理由，这意味着在遇到问题时很容易找到解决方案和资源。不过，对于只需要简单构建流程的小型项目，Hatch 也是一个很好的选择。而对于那些需要高度定制化构建步骤的复杂项目，Setuptools 仍然值得考虑。
