# Installation of Cartopy in Julia

The instructions have been tested on a machine running under Linux (Ubuntu 22.04.3 LTS).

1. Start a Jupyter session, selecting a Julia kernel (I use 1.9.4 but no need to get the last Julia release)
```bash
jupyter-notebook
```
2. Add the [`PyCall`](https://github.com/JuliaPy/PyCall.jl) module with:
```julia
using Pkg
Pkg.add("PyCall")
```

    Import Pycall module:
    using PyCall
    Install cartopy:
    using Conda; Conda.add("Cartopy")
    Test the installation:

    using PyPlot, PyCall
    ccrs = pyimport("cartopy.crs")
    feature = pyimport("cartopy.feature")
    lat = 15 # degrees
    lon = -50 # degrees
    ax = subplot(projection=ccrs.NorthPolarStereo())
    ax.set_global() 
    ax.add_feature(feature.OCEAN, color="navy")
    ax.add_feature(feature.LAND, color="lightgray")
    axis("off")

    which should provide a world map.
    (the projection can obviously be changed).