# Installation of Cartopy in Julia

The instructions have been tested 
- on a machine running under Linux (`Ubuntu 22.04.3 LTS`),
- with Julia version 1.9.4 

1. Start a Jupyter session, selecting a Julia kernel (I
```bash
jupyter-notebook
```
2. Add the [`PyCall`](https://github.com/JuliaPy/PyCall.jl) and [`Conda`](https://github.com/JuliaPy/Conda.jl) modules:
```julia
using Pkg
Pkg.add("PyCall")
Pkg.add("Conda")
```
3. Import the `Pycall` module:
```julia
using PyCall
```
4. Install [`cartopy`](https://scitools.org.uk/cartopy/docs/latest/) using `conda`:
```julia
using Conda; Conda.add("Cartopy")
```
5. Test the installation with a simple plot:
```julia
using PyPlot
ccrs = pyimport("cartopy.crs")
cfeature = pyimport("cartopy.feature")
lat = 15. # degrees
lon = -50. # degrees
ax = subplot(projection=ccrs.NorthPolarStereo())
ax.set_global() 
ax.add_feature(feature.OCEAN, color="navy")
ax.add_feature(feature.LAND, color="lightgray")
axis("off")
```
which should provide the following figure:

![Polar projection](../figs/polarproj.png)

The full example can be tested in the notebook [cartopy_example.ipynb](../src/cartopy_example.ipynb).