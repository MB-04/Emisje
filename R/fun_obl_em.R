#' Funkcja obliczenia emisji spalin
#'
#' Funkcja oblicza emisje korzystajac z danych zawartych w obiekcie
#' \code{wskazniki}, a tazke \code{input}.
#' W obiekcie \code{wskazniki} zapisane sa dane o emisji pobrane z EEA.
#' W obiekcie \code{input} zapisane sa stworzone losowo dane o natezeniu ruchu.
#'
#' @details Wzor na obliczenie emisji:
#' Emisja = Nat x ((Alpha x Procent ^ 2 + Beta x Procent + Gamma + (Delta/Procent))/
#'          (Epsilon x Procent ^ 2 + Zita x Procent + Hta) x (1-Reduction))
#'
#' @param dane data_frame - dane wejsciowe
#' @param kategoria character - kategoria pojazdu
#' @param euro character - europejski standard emisji spalin
#' @param mode character - miejsce pomiaru
#' @param substancja character - typ emitowanego zanieczyszczenia
#'
#' @return data_frame
#'
#' @export
#' @examples
#' \dontrun{
#' # Parametry domyslne
#'   fun_obl_em()
#' # parametry zmodyfikowane
#'   fun_obl_em(dane = input,
#'              kategoria = "Buses",
#'              euro = "Euro III",
#'              mode = "",
#'              substancja = "CO)
#' }
fun_obl_em <- function(dane = input,
                       kategoria = "Passenger Cars",
                       euro = "Euro 5",
                       mode = "",
                       substancja = c("CO", "EC")) {

  wynik <- wskazniki %>%
    filter(Category %in% kategoria) %>%
    filter(Euro.Standard %in% euro) %>%
    filter(Pollutant %in% substancja) %>%
    filter(Mode %in% mode)

  wynik <- dplyr::inner_join(x = wynik, y = input, by = c("Segment","Fuel","Technology"))

  wynik <- wynik%>%
    mutate(Emisja = Nat * ((Alpha * Procent ^ 2 + Beta * Procent + Gamma + (Delta/Procent))/
                                    (Epsilon * Procent ^ 2 + Zita * Procent + Hta) * (1-Reduction))
    )%>%
    select(Category, Fuel, Euro.Standard, Technology, Pollutant, Mode, Segment, Nat, Emisja)

  wynik <<- data.frame(wynik)
  return(wynik)
}
