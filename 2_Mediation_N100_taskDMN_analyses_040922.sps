* Encoding: UTF-8.
* Anika Guha.
* Mediation Analyses.
* Using Process Macro, evaluate mediation of effect of group (SZ vs. HC) on N100 variables by task-based theta coherence.


* task theta --> S1.
process x=Group/y=N100_S1/m=task_theta_coherence/model=4

* task theta --> ratio.
process x=Group/y=N100_Ratio/m=task_theta_coherence/model=4
    
* task theta --> S2.
    
process x=Group/y=N100_S2/m=task_theta_coherence/model=4
    
