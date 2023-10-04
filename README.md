# task_based_DMN_SZ_N100
Processing scripts used for "Task-based default mode network connectivity predicts cognitive impairment and negative symptoms in first-episode schizophrenia" project

MATLAB Script:

**FieldTrip_group_differences_DMN_conn.m**
- Uses FieldTrip to take imaginary part of coherence output from BESA Connectivity (calculated between nodes of DMN) to calculate group differences (SZ vs. HC) in connectivity via cluster-based nonparametric permutation testing. DMN suppression assessed by examining baseline-adjusted (pre-S1) intra-network DMN coherence following S1.

SPSS Syntax Files:

**1_Moderation_stats_Group_N100_DMN_analyses_032822.sps**
- Code for calculating primary regression analyses evaluating relationships between group (SZ vs. HC), N100 variables, and intra-DMN coherence extracted from the theta band cluster (from above Matlab script)

**2_Mediation_N100_taskDMN_analyses_040922.sps**
- Code for calculating mediation of effect of group (SZ vs. HC) on N100 variables as potentially mediated by intra-DMN coherence extracted from the theta band cluster (from above Matlab script) suing the PROCESS Macro

**3_DMN_SANS_SAPS_MATRICS_analyses_081522.sps**
- Code for regression analyses evaluating relationships between intra-DMN theta coherence and symptom measures (SANS, SAPS) and MATRICS cognitive measures.
