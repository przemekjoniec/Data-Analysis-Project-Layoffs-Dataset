-- Exploratory Data Analysis

SELECT * FROM layoffs_cleaned_data;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_cleaned_data;

SELECT *
FROM layoffs_cleaned_data
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_cleaned_data
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_cleaned_data;

SELECT industry, SUM(total_laid_off)
FROM layoffs_cleaned_data
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_cleaned_data
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_cleaned_data
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_cleaned_data
GROUP BY stage
ORDER BY 1 DESC;

SELECT company, AVG(percentage_laid_off)
FROM layoffs_cleaned_data
GROUP BY company
ORDER BY 2 DESC;

SELECT substr(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_cleaned_data
WHERE substr(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_total AS 
(
SELECT substr(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_cleaned_data
WHERE substr(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off,
SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_total;

SELECT company, SUM(total_laid_off)
FROM layoffs_cleaned_data
GROUP BY company
ORDER BY 2 DESC;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_cleaned_data
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH Company_year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_cleaned_data
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS 
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;

WITH industry_year (industry, years, total_laid_off) AS
(
SELECT industry, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_cleaned_data
GROUP BY industry, YEAR(`date`)
), industry_Year_Rank AS 
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM industry_year
WHERE years IS NOT NULL
)
SELECT *
FROM industry_Year_Rank
WHERE Ranking <= 5;























