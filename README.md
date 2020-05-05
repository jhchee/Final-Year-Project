# Final-Year-Project

FYP title: Assessing the effect of genotype-phenotype mapping on the coevolutionary process operates in hypercube graph
<br />
<br />
index terms: coevolutionary system, genotype-phenotype mapping, markov chain, graph theory, group theory
<br />
<br />

### Abstract (taken from the report)

In this study, first, it is shown that a particular setup of the coevolutionary algorithm (CoEA) can give rise to a hypercube structure genotypic state space graph. With the inclusion of distance metric in this state space, some genotype-phenotype mappings are revealed to induce the same coevolutionary process. The identification of these mapping is through isometry transformations performed on the genotypic state space. The implementation is demonstrated through a new interpretation added on the movement of phenotypes - bit flip on the corresponding genotype. An efficient implementation is provided for these transformations. The attempt is shown to be able to scale to any hypercube dimension 3.

Later, a study is conducted to investigate the genotype-phenotype mappings that would bring the largest disturbance to the coevolutionary process. This is with the focus on the structures of the genotypic state space given by the mapping. It is shown that specific structural differences in the genotypic state space can impact the underlying coevolutionary processes. In the demonstration, the PageRank is used to address those structural differences. The limitation of this metric is also being pointed out at last when certain types of mapping is considered.

<br />

### Instruction

- For the first run, execute the file titled "run_script_all_config.m"
- To run specific configuration, specify your configuration and execute the file titled "run_script_specific_config.m"

### Folder structure

- "auxilliary function": auxilliary functions
- "experiment": all figures and results generated for the report
- "group_mapping": group mappings with to same solution space
- "hitting_time_calculation": calculate hitting time for absorbing chain
- "one_norm_calculation": PageRank one norm calculation
- "page_rank_calculation": PageRank result computation

### Special note

- file named "config.mat" is the configuration file, make sure generate this file before running any experiment

### Data link

[Experiment data generated can be assessible here](https://numcmy-my.sharepoint.com/:f:/g/personal/hcyjc3_nottingham_edu_my/EnQiPpToVB9MvPRtcN2AK3gB86g8abLByJBNAMj5EodoKw?e=XKprJD)
- you can create a folder named "data" at the root directory and copy all experiment data into it
