normalize_manually <- function(df){
    ########################## make input data distributed normaly
    cat("normalize data manually \n")
    
    df[, "DER_mass_MMC"] <- log( df[, "DER_mass_MMC"] )
    df[, "DER_mass_transverse_met_lep"] <- 
        (df[, "DER_mass_transverse_met_lep"])^0.25
    df[, "DER_mass_vis" ] <- log( df[, "DER_mass_vis" ] )
    df[, "DER_pt_h"] <- (df[, "DER_pt_h"])^0.4
    df[, "DER_deltaeta_jet_jet"] <- (df[, "DER_deltaeta_jet_jet"])^0.6
    df[, "DER_mass_jet_jet"] <- log( df[, "DER_mass_jet_jet"] )
    df[, "DER_deltar_tau_lep"] <- (df[, "DER_deltar_tau_lep"])^0.7
    df[, "DER_pt_tot"] <- (df[, "DER_pt_tot"])^0.25
    df[, "DER_sum_pt"] <- log( df[, "DER_sum_pt"] )
    df[, "DER_pt_ratio_lep_tau"] <- log( df[, "DER_pt_ratio_lep_tau"] )
    df[, "DER_met_phi_centrality"] <- (df[, "DER_met_phi_centrality"])^4
    df[, "PRI_tau_pt"] <- log( df[, "PRI_tau_pt"] )
    df[, "PRI_lep_pt"] <- log( df[, "PRI_lep_pt"] )
    df[, "PRI_met"] <- (df[, "PRI_met"])^0.2
    df[, "PRI_met_sumet"] <- (df[, "PRI_met_sumet"])^0.1
    df[, "PRI_jet_leading_pt"] <- log( df[, "PRI_jet_leading_pt"] )
    df[, "PRI_jet_subleading_pt"] <- (df[, "PRI_jet_subleading_pt"])^0.1
    df[, "PRI_jet_all_pt"] <- (df[, "PRI_jet_all_pt"])^0.1    

    cat("manual normalizing complete \n")
    return(df)

}
