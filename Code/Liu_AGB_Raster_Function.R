liu.raster.fun = function(liu.fp) {
  library(ncdf4)
  
  # Open Liu AGBc netCDF file
  liu.nc = nc_open(list.files(liu.fp, pattern = '.nc', full.names = TRUE))
  
  # Extract lat/lon attributes
  lat = ncvar_get(liu.nc, 'latitude')
  lon = ncvar_get(liu.nc, 'longitude')
  
  # Extract AGBc variable (matrix)
  liu.agb.mat = ncvar_get(liu.nc, 'Aboveground Biomass Carbon')
  
  # Close netCDF file
  nc_close(liu.nc)
  
  # Get spatial extent of Liu dataset
  liu.ext = c(min(lon), max(lon), min(lat), max(lat))
  
  # Set spatial coordinate reference system variable
  liu.crs = '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'
  
  # Create initial rasterized matrix
  initial.ras = raster(liu.agb.mat[,,1])
  extent(initial.ras) = liu.ext
  crs(initial.ras) = liu.crs
  
  # Set output raster stack for all subsequent years/matrix layers
  out.stack = stack(initial.ras)
  
  for (i in 2 : dim(liu.agb.mat)[3]){
    ras = raster(liu.agb.mat[,,i])
    extent(ras) = liu.ext
    out.stack = stack(ras, out.stack)
  }
  
  # Set names for raster stack (years 1993 to 2012)
  names(out.stack) = as.character(seq(1993,2012,1))
  
  # Return output raster stack (multiply by 2.2 to convert from MgC/ha to Mg/ha)
  return(out.stack * 2.2)
}