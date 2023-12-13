module MVREDIVAnd

using NCDatasets
using Dates

"""
    read_data_nc

Read the coordinates and the variable from the netCDF file `datafile`.
The variable is determined by its long name.
"""
function read_data_nc(datafile::AbstractString, long_name::String)
    NCDataset(datafile) do ds
        nstations = ds.dim["N_STATIONS"]
        nsamples = ds.dim["N_SAMPLES"]

        lon = coalesce.(NCDatasets.varbyattrib(ds, standard_name="longitude")[1]|> Array, NaN)
        lat = coalesce.(NCDatasets.varbyattrib(ds, standard_name="latitude")[1]|> Array, NaN)
        pressure = coalesce.(NCDatasets.varbyattrib(ds, long_name="Pressure")[1]|> Array, NaN)
        time = coalesce.(NCDatasets.varbyattrib(ds, standard_name="time")[1]|> Array, NaN)
        thevar = NCDatasets.varbyattrib(ds, long_name=long_name)[1]
        var = thevar |> Array
        varunits = thevar.attrib["units"]
        return lon::Vector{Float32}, lat::Vector{Float32}, 
        pressure::Matrix{AbstractFloat}, time::Vector{DateTime}, var::Matrix{Union{Missing, Float32}}, varunits::String
    end
end

"""
    vectorise_data(lon, lat, pressure, time, var)

Transform the observation matrix into an array from which the missing values have been removed.

# Example
```julia-repl
julia> vectorise_data(lon, lat, pressure, time, var)
```
"""
function vectorise_data(lon, lat, pressure, time, var)
    nsamples, nprofiles = size(var)
    lonall = Float64[]
    latall = Float64[]
    pressureall = Float64[]
    timeall = Dates.DateTime[]
    varall = Float64[]

    # Loop on the profiles
    for iii in 1:nprofiles
        var_profile = var[:,iii];
        goodlevels = findall(.!ismissing.(var_profile))
        npoints = length(goodlevels)
        @debug("Found $(npoints) good data points in the profile")
        var_profile = var_profile[goodlevels]
        pressure_profile = pressure[goodlevels, iii]
        lon_profile = fill(lon[iii], npoints)
        lat_profile = fill(lat[iii], npoints)
        time_profile = fill(time[iii], npoints)
        append!(lonall, lon_profile)
        append!(latall, lon_profile)
        append!(timeall, time_profile)
        append!(pressureall, pressure_profile)
        append!(varall, var_profile)
    end 
    return lonall::Vector{Float64}, latall::Vector{Float64}, pressureall::Vector{Float64}, timeall::Vector{DateTime},
           varall::Vector{Float64}
end

end #end of module