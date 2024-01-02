library(raster)

# Set directory filepaths
repo.code.fp = getwd()
setwd('../')
repo.data.fp = paste(getwd(), 'Data', sep = '/')
setwd('../../')
root.fp = getwd()
data.fp = paste(root.fp, 'Data', 'AGB', 'Southwest', sep = '/')
shp.fp = paste(repo.data.fp, 'Shapefiles', sep = '/')

# Get shapefiles for spatial subsets
sw.shps = list.files(shp.fp, pattern = '.shp', full.names = TRUE)
sw.box = shapefile(sw.shps[3])
gw.box = shapefile(sw.shps[1])
nnss.box = shapefile(sw.shps[2])
ws.box = shapefile(sw.shps[4])

# ------------ Read 2010 AGB data products

# Chopping
chopping.agb.2010 = stack(paste(data.fp, 'Chopping', 'MISR_agb_estimates_20002021.tif', sep = '/'))[[10]]

# Liu
source(paste(repo.code.fp, 'Liu_AGB_Raster_Function.R', sep = '/'))
liu.agb = liu.raster.fun(paste(data.fp, 'Liu', sep = '/'))
liu.agb.2010 = liu.agb[[8]]

# ESA CCI
esa.agb.2010.f1 = raster(list.files(paste(data.fp, 'ESA_CCI', sep = '/'), pattern = '.tif', full.names = TRUE)[1])
esa.agb.2010.f2 = raster(list.files(paste(data.fp, 'ESA_CCI', sep = '/'), pattern = '.tif', full.names = TRUE)[2])

# Xu
xu.agb.2010 = stack(paste(data.fp, 'Xu', 'test10a_cd_ab_pred_corr_2000_2019_v2.tif', sep = '/'))[[10]] * 2.2
