## helper functions for DET gel sampler application ##
### exctraction of gel slices

#### volume from gel slice geometry:
DET.slice.volume.ccm <- function(slice.width.mm,
                                 gel.thickness.mm = 1,
                                 DET.window.width.mm = 20, ...){
  slice.width.mm * gel.thickness.mm * DET.window.width.mm / 1000
}

#### solute amount in gel slice from ambient solute concentration during application:
DET.slice.amount.uM <- function(V.slice.ccm, c.ambient.uM, ...){
  if (missing(V.slice.ccm)) {
    V.slice.ccm <- DET.slice.volume.ccm(...)
  }
  c.ambient.uM * V.slice.ccm * 1e-3 # conversion from liters to ccm
}

#### extract concentration from extraction volume:
DET.extract.conc.uM <- function(n.slice.umol, 
                                V.slice.ccm,
                                V.extraction.uL, ...){
  if (missing(V.slice.ccm)) {
    V.slice.ccm <- DET.slice.volume.ccm(...)
  }
  if (missing(n.slice.umol)) {
    n.slice.umol <- DET.slice.amount.uM(V.slice.ccm, ...)
  }
  n.slice.umol / (V.slice.ccm * 1e-3 + V.extraction.uL * 1e-6)
}


