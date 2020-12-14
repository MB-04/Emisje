#' Funkcja wizualizacji wynikow Emisji
#'
#' Funkcja rysuje wykresy emisji na podstawie danych utworzonych za pomoca \code{fun_obl_em()}
#'
#' @param data data_frame
#' @param kategoria1 character - wybor pierwszej kolumny z data
#' @param wartosci1 character - wybor wartosci filtrujacej pierwsza kolumne
#' @param kategoria2 character - wybor drugiej kolumny
#' @param wartosci2 double - wybor kolumny z wartosciami double
#' @param fname character - nazwa pliku wykresu ktory zostanie zapisany
#' @param width double - szerokosc
#' @param height double - wysokosc
#' @param dpi double - liczba punktow na cal
#'
#' @return plot
#'
#' @export
#' @examples
#' \dontrun{
#' # Narysowanie wykresu domyslnego:
#' fun_em_plot()
#' # Narysowanie wykresow dla przykladowych danych:
#' fun_em_plot(dane = wynik,
#'            kategoria1 = Euro.Standard,
#'            wartosci1 = "Euro 5",
#'            kategoria2 = Segment,
#'            wartosci2 = Nat,
#'            fname = "plik2.png",
#'            width = 10,
#'            height = 8,
#'            dpi = 600)
#'}
fun_em_plot <- function(data = wynik,
                        kategoria1 = Category,
                        wartosci1 = "Passenger Cars",
                        kategoria2 = Segment,
                        wartosci2 = Emisja,
                        fname = "plik.png", width = 8, height = 6, dpi = 300) {

  kategoria1 <- enquo(kategoria1)
  kategoria2 <- enquo(kategoria2)
  wartosci2  <- enquo(wartosci2)


  if (!is.null(wartosci1)) {
    data <- data %>%
      filter(!!kategoria1 %in% wartosci1)
  }

  start <-1
  while (start == 1) {
    writeLines("Wykres punktowy - 1")
    writeLines("Boxplot - 2")
    readline(prompt = "Podaj rodzaj wykresu: ") -> wykres

    if (wykres==1) {
      ggplot(data, aes(x = !!kategoria2,
                       y = !!wartosci2,
                       color = !!kategoria2)) +
        geom_point()+
        labs(title = "Zaleznosc wartosci parametru emisji od wybranego segmentu",
             x = "Typ segmentu pojazdu",
             y = "Wartosci Emisji",
             color = "Segment") -> plot
      start<-2
    }
    else if (wykres==2) {
      ggplot(data, aes(x = !!kategoria2,
                       y = !!wartosci2,
                       fill = !!kategoria2)) +
        geom_boxplot(outlier.shape = NA,
                     col="red") +
        theme_grey() +
        theme(text = element_text(face = "bold")) +
        labs(title = "Zaleznosc wartosci parametru emisji od wybranego segmentu",
             x = "Typ segmentu pojazdu",
             y = "Wartosci Emisji",
             color = "Segment") -> plot
      start<-2
    }
  }

  ggsave(filename = fname,
         plot = plot,
         width = width,
         height = height,
         dpi = dpi)

  return(plot)
}
