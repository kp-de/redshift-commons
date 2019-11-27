-- Use this script to populate dim_date
Create table number_series
(
 number int 
)
;

-- Insert numbers from 0 to 100000 in this table

Insert into number_series
(
  Select generate_series(0,100000,1)
)
;

--- Loop through the numbers above to generate date records

INSERT INTO dim_date
(
   "date_id"
  ,"full_date"
  ,"year_number"
  ,"year_week_number"
  ,"year_day_number"

  -- QUARTER
  ,"qtr_number"

  -- MONTH
  ,"month_number"
  ,"month_name"
  ,"month_day_number"

  -- WEEK
  ,"week_day_number"

  -- DAY
  ,"day_name"
  ,"day_is_weekday"
  ,"day_is_last_of_month"
)
  SELECT
    cast(seq + 1 AS INTEGER)                                      AS date_id,

    -- DATE
    datum                                                         AS full_date,

    -- YEAR
    cast(extract(YEAR FROM datum) AS SMALLINT)                    AS year_number,
    cast(extract(WEEK FROM datum) AS SMALLINT)                    AS year_week_number,
    cast(extract(DOY FROM datum) AS SMALLINT)                     AS year_day_number,

    -- QUARTER
    cast(to_char(datum, 'Q') AS SMALLINT)                         AS qtr_number,

    -- MONTH
    cast(extract(MONTH FROM datum) AS SMALLINT)                   AS month_number,
    to_char(datum, 'Month')                                       AS month_name,
    cast(extract(DAY FROM datum) AS SMALLINT)                     AS month_day_number,

    -- WEEK
    cast(to_char(datum, 'D') AS SMALLINT)                         AS week_day_number,

    -- DAY
    to_char(datum, 'Day')                                         AS day_name,
    CASE WHEN to_char(datum, 'D') IN ('1', '7')
      THEN 0
    ELSE 1 END                                                    AS day_is_weekday,
    CASE WHEN
      extract(DAY FROM (datum + (1 - extract(DAY FROM datum)) :: INTEGER +
                        INTERVAL '1' MONTH) :: DATE -
                       INTERVAL '1' DAY) = extract(DAY FROM datum)
      THEN 1
    ELSE 0 END                                                    AS day_is_last_of_month
  FROM
    -- Generate days for 80 years starting from 2000.
    (
      SELECT
        '2000-01-01' :: DATE + number AS datum,
        number                        AS seq
      FROM number_series
      WHERE number between 0 and 80 * 365 + 20
    ) DQ
  ORDER BY 1;
