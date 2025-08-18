#' Lagged Scatter Plot
#'
#' This function creates a scatter plot of lagged time series data,
#' highlighting the correlation between two variables at different lags.
#' The plot can be a regular scatter plot or a hexbin plot.
#'
#' @param object An S4 object containing time series data and associated information
#'               such as global indices, maximum correlation indices, shift times,
#'               and correlation values.
#' @param x_name The name to be used for the x-axis label, defaults to "x".
#' @param y_name The name to be used for the y-axis label, defaults to "y".
#' @param which Determines the type of index to use for plotting, either "global" or "max".
#'              "global" uses the global index and "max" uses the index of maximum correlation.
#'              Defaults to c("global", "max").
#' @param hex A logical value, if TRUE, a hexbin plot will be created, otherwise a regular
#'            scatter plot. Defaults to FALSE.
#'
#' @return A ggplot object representing the lagged scatter plot with appropriate annotations.
#'
#' @details The function calculates the average y-values at specific lags defined by the
#'          index chosen (global or max). The scatter plot is then created using ggplot2
#'          and further annotated with correlation information. If `hex` is TRUE, the plot
#'          uses `stat_binhex` to create hexagonal binning. Otherwise, points are plotted
#'          directly with `geom_point`. A linear model fit is added in both cases using
#'          `geom_smooth`.
#'
#'
#' @note The function expects the `object` to have specific slots: `@global_idx`, `@max_idx`,
#'       `@shift_time`, `@global_cor`, `@max_cor`, `@which_max_idx`, `@time1`, `@time2`,
#'       `@x`, and `@y`. If `hex` is TRUE, `@which_global_idx` is also used. It is important
#'       to ensure these slots are present in the object passed to the function. Also,
#'       the function assumes that `base_theme` is defined elsewhere in the user's environment.
#' @author Xiaotao Shen
#' \email{shenxt1990@@outlook.com}
#' @export
#' @examples
#' data("object", package = "lagci")
#' lagged_scatter_plot(
#'   object = object,
#'   x_name = "Step",
#'   y_name = "HR",
#'   hex = TRUE,
#'   which = "max"
#' )
#'
#' lagged_scatter_plot(
#'   object = object,
#'   x_name = "Step",
#'   y_name = "HR",
#'   hex = TRUE,
#'   which = "global"
#' )

lagged_scatter_plot <-
  function(object,
           x_name = "x",
           y_name = "y",
           which = c("global", "max"),
           hex = FALSE) {
    which <- match.arg(which)

    if (is.null(object)) {
      return(NULL)
    }

    step <- object@parameter@parameter$step
    if (is.null(step)) {
      stop("step information is missing in the result object")
    }

    time1 <- object@time1
    time2 <- object@time2
    x <- object@x
    y <- object@y

    # align two series using the same procedure as in calculate_lagged_correlation
    start_time <- max(min(time1), min(time2))
    end_time <- min(max(time1), max(time2))
    target_freq <- paste(step * 60, "min")
    regular_times <- seq(from = start_time, to = end_time, by = target_freq)

    x_aligned <- approx(x = time1, y = x, xout = regular_times, method = "linear")$y
    y_aligned <- approx(x = time2, y = y, xout = regular_times, method = "linear")$y

    # calculate lag in number of steps from shift_time string
    shift_time_num <- sapply(object@shift_time, function(x) {
      x %>%
        stringr::str_replace("\\(", "") %>%
        stringr::str_replace("\\]", "") %>%
        stringr::str_split(",") %>%
        `[[`(1) %>%
        as.numeric() %>%
        mean()
    })

    lag_steps <- round(shift_time_num / (step * 60))

    sel_idx <- if (which == "max") object@which_max_idx else object@which_global_idx
    lag_step <- lag_steps[sel_idx]

    if (lag_step > 0) {
      x2 <- x_aligned[(lag_step + 1):length(x_aligned)]
      y2 <- y_aligned[1:(length(y_aligned) - lag_step)]
    } else if (lag_step < 0) {
      lag_step <- abs(lag_step)
      x2 <- x_aligned[1:(length(x_aligned) - lag_step)]
      y2 <- y_aligned[(lag_step + 1):length(y_aligned)]
    } else {
      x2 <- x_aligned
      y2 <- y_aligned
    }

    value <- data.frame(x2, y2)


    
    if (hex) {
      plot =
        value %>%
        ggplot(aes(x2, y2)) +
        stat_binhex(aes(fill = log(..count..))) +
        # geom_hex(fill=log(..count..)) +
        geom_smooth(method = "lm") +
        base_theme +
        labs(x = y_name, y = x_name) +
        scale_fill_gradient(low = ggsci::pal_aaas()(n = 10)[1],
                            high = ggsci::pal_aaas()(n = 10)[2])
    } else{
      plot =
        value %>%
        ggplot(aes(x2, y2)) +
        geom_point(size = 3) +
        geom_smooth(method = "lm") +
        base_theme +
        labs(x = y_name, y = x_name)
    }
    
    if (which == "max") {
      correlation =
        object@max_cor
      correlation_p = object@all_cor_p[object@which_max_idx]
      shift_time = object@shift_time[object@which_max_idx]
    } else{
      correlation =
        object@global_cor
      correlation_p = object@all_cor_p[object@which_global_idx]
      shift_time = object@shift_time[object@which_global_idx]
    }
    
    plot =
      plot +
      annotate(
        geom = "text",
        x = -Inf,
        y = Inf,
        hjust = 0,
        vjust = 1,
        label = paste(
          "Correlation: ",
          round(correlation, 4),
          "\n",
          "p-value: ",
          correlation_p,
          "\n",
          "Shift time: ",
          shift_time
        )
      )
    
    return(plot)
  }