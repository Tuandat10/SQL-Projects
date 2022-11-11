-- Select all information from the dataset
select * from PortfolioProject.dbo.dataset

-- Change the data type of column
alter table PortfolioProject.dbo.dataset
alter column popularity INT 
alter table PortfolioProject.dbo.dataset
alter column time_signature INT 

-- Do some EDA to understand the information
-- See the total number of observations in this dataset
select count(track_id) from PortfolioProject.dbo.dataset
-- There is 114000 records

-- Select the information we need to EDA and remove the unnecessary details
select "index" as "index", track_id, artists, album_name, track_name, popularity, time_signature, track_genre
from PortfolioProject.dbo.dataset

-- Whether if there are artists have more than one album in Sportify
select artists, count(artists) as count_artists
from PortfolioProject.dbo.dataset
group by artists
order by count_artists desc
-- There several artists have more than 1 album, especially The Beatles has 279 albums in Sportify

-- See all the albums that have the 0 popularity
select "index" as "index", track_id, artists, album_name, track_name, popularity, time_signature, track_genre
from PortfolioProject.dbo.dataset
where popularity = 0

-- Showing the average score of popularity from top to low.

select artists,count(artists) as count_art, avg(popularity) as avg_popularity
from PortfolioProject.dbo.dataset
group by artists
order by avg_popularity desc, count_art desc
-- It seems that Sam Smith and Kim Petras have the impossible average score of popularity, which is 100. In overall, There are few artists whose albums have the score of popularity above 90.

-- What are the paricular track_genre in the dataset
select track_genre,count(track_genre) as count_genre
from PortfolioProject.dbo.dataset
group by track_genre
order by track_genre desc

-- Suprisingly there are 1000 observations for each genre

-- I am a fan of the beatles, so I want to know whether besides having their own albums, they have collab with the others.
select artists, count(artists) as count_art
from PortfolioProject.dbo.dataset
where artists like '%The Beatles%'
group by artists
-- The Beatles has 279 their own albums and 1 album that they collab with Billy Preston

