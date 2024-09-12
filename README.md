# Identifying Interpretable Discrete Latent Structures from Discrete Data


This repository is associated with the paper [Gu, Y. and Dunson, D.B. (2021), Bayesian Pyramids: Identifiable Multilayer Discrete Latent Structure Models for Discrete Data](https://arxiv.org/abs/2101.10373).


### Abstract
High dimensional categorical data are routinely collected in biomedical and social sciences. It is of great importance to build interpretable parsimonious models that perform dimension reduction and uncover meaningful latent structures from such discrete data. Identifiability is a fundamental requirement for valid modeling and inference in such scenarios, yet is challenging to address when there are complex latent structures. In this article, we propose a class of identifiable multilayer (potentially deep) discrete latent structure models for discrete data, termed Bayesian pyramids. We establish the identifiability of Bayesian pyramids by developing novel transparent conditions on the pyramid-shaped deep latent directed graph. The proposed identifiability conditions can ensure Bayesian posterior consistency under suitable priors. As an illustration, we consider the two-latent-layer model and propose a Bayesian shrinkage estimation approach. Simulation results for this model corroborate the identifiability and estimability of model parameters. Applications of the methodology to DNA nucleotide sequence data uncover useful discrete latent features that are highly predictive of sequence types. The proposed framework provides a recipe for interpretable unsupervised learning of discrete data, and can be a useful alternative to popular machine learning methods.


### For simulations:
Note that all Matlab functions and source code files are under `matlab_source_code/`. Run `generate_2layer_data_strong.m` to generate simulated data. Then run the function `bp_csp_simu(K, alpha0)` to perform simulations with Gibbs sampling to estimate the parameters. See the meaning and discussion of K and alpha0 in the paper. Then run `simu_post_process.m` and `simu_figure.m` to evaluate and visualize the estimation results from the simulations.


### For real data analysis:
Take the splice junction dataset analyzed in the paper as an example. Run the function `splice_csp(K, alpha0)` to analyze the splice junction data using the proposed method. Then use `splice_processing.m` and `python_corels/splice.py` to perform downstream classification using the rule-list classifier. Then run `splice_csp_figure.m` to generate figures to evaluate and visualize the data analysis results.


### Generate some simple data and then run the proposed method on it:
Matlab script `demo_run.m` is a simple, readable, and short script which first generates a simulated dataset `Y_data.csv`, and then runs the proposed method on it using the `bayes_pyramid('Y_data.csv')` function and returns the `saved_file` containing all the estimation results. Finally, the last line of the script `load(saved_file)` loads all the estimation results into the current Matlab workspace.

### 识别可解释的离散数据中的离散潜在结构

该仓库与以下论文相关：[Gu, Y. 和 Dunson, D.B. (2021)，贝叶斯金字塔：用于离散数据的可识别多层离散潜在结构模型](https://arxiv.org/abs/2101.10373)。

### 摘要
在生物医学和社会科学中，经常会收集到高维的分类数据。构建具有解释性且简洁的模型，对于在这些离散数据中执行降维操作和揭示有意义的潜在结构至关重要。可识别性是这些场景中进行有效建模和推断的基础要求，但当存在复杂的潜在结构时，这一问题具有挑战性。本文提出了一类可识别的多层（可能是深层）离散潜在结构模型，专用于处理离散数据，我们将其称为**贝叶斯金字塔**。通过对金字塔形状的深层潜在有向图开发新的透明条件，我们确立了贝叶斯金字塔的可识别性。这些可识别性条件在合适的先验条件下能够保证贝叶斯后验的一致性。作为示例，我们讨论了两层潜在层模型，并提出了一种贝叶斯收缩估计方法。该模型的仿真结果验证了模型参数的可识别性和可估性。将该方法应用于DNA核苷酸序列数据，揭示了高度预测序列类型的有用离散潜在特征。所提出的框架为离散数据的可解释无监督学习提供了指导，并且可以作为流行机器学习方法的有用替代方案。

### 关于仿真：
所有的Matlab函数和源代码文件都在`matlab_source_code/`目录下。运行`generate_2layer_data_strong.m`来生成模拟数据。然后运行函数`bp_csp_simu(K, alpha0)`，通过Gibbs采样来估计参数。关于K和alpha0的含义和讨论，详见论文。之后运行`simu_post_process.m`和`simu_figure.m`，对仿真结果进行评估并可视化。

### 关于真实数据分析：
以论文中分析的**剪接点数据集**为例，运行函数`splice_csp(K, alpha0)`来使用该方法分析剪接点数据。之后使用`splice_processing.m`和`python_corels/splice.py`，利用规则列表分类器执行下游分类任务。最后运行`splice_csp_figure.m`来生成图形，用于评估和可视化数据分析结果。

### 生成一些简单数据并运行提出的方法：
Matlab脚本`demo_run.m`是一个简单、易读且简短的脚本，它首先生成一个模拟数据集`Y_data.csv`，然后使用`bayes_pyramid('Y_data.csv')`函数对其运行所提出的方法，返回包含所有估计结果的`saved_file`。最后，脚本的最后一行`load(saved_file)`将所有的估计结果加载到当前的Matlab工作区中。