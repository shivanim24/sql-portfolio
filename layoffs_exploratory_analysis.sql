Select *
from layoffs_staging2;

Select max(total_laid_off),max(percentage_laid_off)
from layoffs_staging2
;

Select *
from layoffs_staging2
where percentage_laid_off=1
order by total_laid_off desc;

Select company,sum(total_laid_off)
from layoffs_staging2
group by(company)
order by sum(total_laid_off) desc;

Select industry,sum(total_laid_off)
from layoffs_staging2
group by (industry)
order by 2 desc;

select year(`date`),sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

Select company,sum(percentage_laid_off)
from layoffs_staging2
group by(company)
order by sum(percentage_laid_off) desc;

select substring(`date`,1,7) as `month` ,sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by month
order by 1 asc;

with rolling_total as
(
select substring(`date`,1,7) as `month` ,sum(total_laid_off) as sum_tot_laid_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by month
order by 1 asc
)
select `month`,sum(sum_tot_laid_off) over (order by `month`) as rolling_total,sum_tot_laid_off
from rolling_total
order by `month`;

Select company,sum(total_laid_off)
from layoffs_staging2
group by(company)
order by sum(total_laid_off) desc;

select company,year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
order by  3 desc;


with company_year(company,years,total_lay_off) as
(
select company,year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
),company_year_rank as (
select *,dense_rank() over (partition by years order by total_lay_off desc) as `rank`
from company_year
where years is not null
)
select * 
from company_year_rank
where `rank`<=5;

select *
from layoffs_staging2;

select industry,sum(percentage_laid_off)
from layoffs_staging2
group by industry;