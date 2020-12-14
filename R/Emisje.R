#' Pakiet Emisje
#'
#' Pakiet oblicza emisje EMEP/EEA zanieczyszczenia powietrza wybranego rodzaju pojazdu,
#' a takze wizualizujacy za pomoca wykresu wartosci wynikowe.
#'
#' Pakiet zawiera dwie funkcje:
#'
#' \code{fun_obl_em()} oblicza emisje
#'
#' \code{fun_em_plot()} rysuje wykresy emisji
#'
#' @section Dane do obliczen:
#' Funkcje pakietu korzystaja z danych dolaczonych do pakietu.
#'
#' Dane sa dostepne dla uzytkownika jako obiekty \code{input}, \code{wskazniki}.
#'
#' @docType package
#' @name Emisje
#' @import dplyr
#' @import ggplot2
#' @import magrittr
#' @import qpdf
#' @import tidyverse
NULL

utils::globalVariables(c("input", "wskazniki", "wynik"))
