# SIM-TPV
## This is the simulation of the method of ZYS's and WHL's on consensus of TPV model

### 1, Reference:

[1].Dong X, Yu B, Shi Z, et al.

**Time-Varying Formation Control for Unmanned Aerial Vehicles: Theories and Applications[J].**

*Control Systems Technology IEEE Transactions on, 2015, 23(1):340-348.*

[2].Wang H.

**Second-Order Consensus of Networked Thrust-Propelled Vehicles on Directed Graphs[J].**

*IEEE Transactions on Automatic Control, 2016, 61(1):222-227.*

### 2, Notes
Model:
Model is TPV, the input controller are thrust and angular acceleration along three axis. Please go to `model.m` for details.


### 3, Usage
just run `main.m` ;
* flag = 0 : Formation is circle;
* flag = 1 : Formation is parabolic;
* flag = 2 : test for consensus.

### 4, Screenshots
* flag = 0:
ZYS:
![](/figure/Posi_xy_circle@ZYS.JPG )
WHL:
![](/figure/Posi_xy_circle@WHL.JPG )
* flag = 1:
ZYS:
![](/figure/Posi_xy_parabolic@ZYS.JPG )
WHL:
![](/figure/Posi_xy_parabolic@WHL.JPG )
* flag = 2:
ZYS:
![](/figure/Posi_xy_consensus@ZYS.JPG )
WHL:
![](/figure/Posi_xy_consensus@WHL.JPG )
