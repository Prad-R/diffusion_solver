# 2D Steady-State Diffusion Equation Solver

This solver is designed to solve equations of the form

$$
0 = \frac{\partial}{\partial x} \left( k \frac{\partial \phi}{\partial x} \right) + \frac{\partial}{\partial y} \left( k \frac{\partial \phi}{\partial y} \right) + S
$$

where $k$ is the coefficient of conductivity (can be defined to be varying the domain), $S$ is a linearized source term, and $\phi$ is the variable of interest.

## Boundary Conditions

The boundary conditions of the various domains can be modified by altering any one of the following files

- ```left_face.m```
- ```top_face.m```
- ```right_face.m```
- ```bottom_face.m```

Be sure to adjust ```boundaty_conditions.m``` after altering a Neumann condition to a Dirichlet condition or vice versa.

To alter the variation of $k$ in the domain, alter ```find_k.m```.

## Using the Solver

Once the necessary setup is completed, run the ```main.m``` file to run the solver. The results will be stored in the [Plots](Plots) and [Data](Data) directories.

## Example

To view a solved example, read the PDF file inside [AM5630___Assignment_2.pdf](AM5630___Assignment_2.pdf). It considers a case described by Case 2 in [AM5630_Assignment_2.pdf](AM5630_Assignment_2.pdf).
