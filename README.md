# Particle Simulation in MATLAB
## Overview

This MATLAB script simulates the movement and interaction of particles in a confined space. It uses a random walk algorithm to model the motion of N particles in a dim x dim grid over a specified number of timesteps. A fraction of these particles are stationary, and the rest move randomly. The script also simulates the spread of an "infection" among these particles and generates a video of the simulation.
Prerequisites

    MATLAB
    MATLAB's VideoWriter package (usually comes with standard MATLAB installation)

## Usage

Open MATLAB: Start the MATLAB application on your computer.

Load the Script: Open the script file in MATLAB.

Configure Parameters: You can modify the parameters at the beginning of the script to customize the simulation. These include:

      N: Number of particles.
      dim: Dimensions of the grid (should be divisible by 4).
      time: Total number of timesteps.
      rat: Ratio of stationary particles.

Run the Script: Execute the script in MATLAB. The simulation will start, and the progress can be viewed in the MATLAB figure window.

View Results: After the simulation ends, a video file named 'video[specified_ratio].mp4' will be generated in the current directory, showing the entire simulation.
