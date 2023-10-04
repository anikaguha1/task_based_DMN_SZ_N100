* Encoding: UTF-8.
* Anika Guha.
* Primary statistical analyses evaluating relationships between group (SZ vs. HC), N100 measures, and task-based DMN theta coherence.

DATASET ACTIVATE DataSet1.

* Within subjects analysis of N100 S1 and S2 amplitudes with between-subjects factor of group.
GLM N100_S1 N100_S2 BY Group
  /WSFACTOR=N100 2 Polynomial 
  /MEASURE=S 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(N100*Group) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=N100 
  /DESIGN=Group.

*task-based DMN coherence, group, and task-based DMN coherence*group effects on N100 S1 amplitude.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT N100_S1
  /METHOD=ENTER task_theta_coherence
  /METHOD=ENTER task_theta_coherence Group
  /METHOD=ENTER task_theta_coherence Group GroupXTaskCoherence.

*task-based DMN coherence, group, and task-based DMN coherence*group effects on N100 ratio (S2/S1).
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT N100_Ratio
  /METHOD=ENTER task_theta_coherence
  /METHOD=ENTER task_theta_coherence Group
  /METHOD=ENTER task_theta_coherence Group GroupXTaskCoherence.

*task-based DMN coherence, group, and task-based DMN coherence*group effects on N100 S2-S1 (suppression analysis akin to ratio).
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT S2_S1_Difference
  /METHOD=ENTER task_theta_coherence
  /METHOD=ENTER task_theta_coherence Group
  /METHOD=ENTER task_theta_coherence Group GroupXTaskCoherence.
