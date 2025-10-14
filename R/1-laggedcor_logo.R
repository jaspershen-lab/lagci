#' @title Show the logo lagci.
#' @description The lagci logo, using ASCII or Unicode characters
#' @author Xiaotao Shen
#' \email{shenxt1990@@outlook.com}
#' @param unicode Whether to use Unicode symbols. Default is `TRUE`
#' on UTF-8 platforms.
#' @return A ASCII log of lagci
#' @export
#' @importFrom dplyr filter mutate select group_by case_when
#' @importFrom tibble tibble
#' @importFrom rlang is_installed
#' @import ggplot2
#' @importFrom plyr dlply .
#' @importFrom utils head tail
#' @importFrom stats cor.test dnorm end loess predict start time
#' @importFrom magrittr %>%
#' @importFrom BiocParallel SnowParam MulticoreParam
#' @import ggrepel
#' @import ggsci
#' @importFrom lubridate ymd_hms date tz as_datetime hour minute month day
#' @import scales
#' @importFrom hms as_hms
#' @importFrom methods new
#' @importClassesFrom massdataset tidymass_parameter
#' @examples
#' lagci_logo()

lagci_logo <- 
  function(unicode = l10n_info()$`UTF-8`) {
  message(crayon::green("Thank you for using lagci!"))
  message(crayon::green("Version", lagci_version, "(", lagci_update_date, ")"))
  message(crayon::green("More information: searching 'jaspershen-lab/lagci'."))
  message(crayon::yellow("I'M USING THE DEVELOPER VERSION OF lagci"))
    
    logo <- c(
      " _                  _ ",
      "| |                (_)",
      "| | __ _  __ _  ___ _ ",
      "| |/ _` |/ _` |/ __| |",
      "| | (_| | (_| | (__| |",
      "|_|\\__,_|\\__, |\\___|_|",
      "          __/ |       ",
      "         |___/        "
    )
    
  
  
  hexa <- c("*", ".", "o", "*", ".", "*", ".", "o", ".", "*")
  if (unicode)
    hexa <- c("*" = "\u2b22", "o" = "\u2b21", "." = ".")[hexa]
  
  cols <- c(
    "red",
    "yellow",
    "green",
    "magenta",
    "cyan",
    "yellow",
    "green",
    "white",
    "magenta",
    "cyan"
  )
  
  col_hexa <- purrr::map2(hexa, cols, ~ crayon::make_style(.y)(.x))
  
  
  for (i in 0:9) {
    pat <- paste0("\\b", i, "\\b")
    logo <- sub(pat, col_hexa[[i + 1]], logo)
  }
  
  structure(crayon::blue(logo), class = "lagci_logo")
}

#' @export

print.lagci_logo <- function(x, ...) {
  cat(x, ..., sep = "\n")
  invisible(x)
}

lagci_version <- 
  utils::packageVersion(pkg = "lagci")

lagci_update_date <- 
  as.character(Sys.Date())
