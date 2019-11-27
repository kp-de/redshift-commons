-- DDL script to create a Date dimension with commonly used columns


CREATE TABLE dim_date (
  "date_id"              INTEGER                     NOT NULL PRIMARY KEY,
  -- DATE
  "full_date"            DATE                        NOT NULL,
  -- YEAR
  "year_number"          SMALLINT                    NOT NULL,
  "year_week_number"     SMALLINT                    NOT NULL,
  "year_day_number"      SMALLINT                    NOT NULL,
  -- QUARTER
  "qtr_number"           SMALLINT                    NOT NULL,
  -- MONTH
  "month_number"         SMALLINT                    NOT NULL,
  "month_name"           CHAR(9)                     NOT NULL,
  "month_day_number"     SMALLINT                    NOT NULL,
  -- WEEK
  "week_day_number"      SMALLINT                    NOT NULL,
  -- DAY
  "day_name"             CHAR(9)                     NOT NULL,
  "day_is_weekday"       SMALLINT                    NOT NULL,
  "day_is_last_of_month" SMALLINT                    NOT NULL
) 
DISTSTYLE ALL 
SORTKEY (date_id)
;
