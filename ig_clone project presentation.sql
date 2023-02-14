							-- IG-CLONE Data Base--

-- Aim:
-- The aim of the project is to retrieve data from the Ig-Clone database by knowing the insights based on the patterns
-- and relationships from the tables,to get solutions for real time problems.


-- 2.We want to reward the user who has been around the longest, Find the 5 oldest users.
select * from users 
order by created_at
limit 5;

-- 3.To understand when to run the ad campaign, figure out the day of the week most users register on? 
select dayname(created_at) Day_name,count(*) Total_users
from users
group by dayname(created_at)
limit 2;

-- 4.To target inactive users in an email ad campaign, find the users who have never posted a photo
select u.id,u.username
from users u left join photos p 
on u.id=p.user_id
where user_id is null
order by u.id;


-- 5.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
select u.id,u.username,count(*) as total_likes
from likes l
join photos p on p.id=l.photo_id
join users u on u.id=p.id
group by u.id
order by total_likes desc 
limit 3;


-- 6.The investors want to know how many times does the average user post.
select (select count(id) from photos)/(select count(id) from users ) average_time;


-- 7.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select id Tag_id,Tag_name,count(*) Total_tags from tags t 
join photo_tags pt on t.id=pt.tag_id
group by id
order by Total_tags desc
limit 5;

-- 8.To find out if there are bots, find users who have liked every single photo on the site.
select user_id,count(*) Total_photos from likes
group by user_id
having Total_photos=(select max(id) from photos)
order by user_id;


-- 9.To know who the celebrities are, find users who have never commented on a photo.
select u.id,u.username from users u left join comments c on u.id=c.user_id
where comment_text is null 
order by u.id;


-- 10.Now it's time to find both of them together, find the users who have never commented 
-- on any photo or have commented on every photo.
(select u.id,u.username,count(photo_id) photos,'commented' as Type from users u left join comments c on u.id=c.user_id
where comment_text is not null group by u.id having photos < (select count(*) from photos))
union all
(select u.id,u.username,count(photo_id) photos,'commented on every photo' as Type from users u left join comments c on u.id=c.user_id
where comment_text is not null group by u.id having photos in (select count(*) from photos))
union all
(select u.id,u.username,count(photo_id) photos,'Never commented' as Type from users u left join comments c on u.id=c.user_id
where comment_text is null group by u.id having photos=0);

  -- conclusion:
  -- I conclude that by knowing insights and relation ships from the tables ,i fetch the required data by 
  -- combining two or more tables using joins,filtered my data by using where clause,sort my data in asc or 
  -- desc by using order by and grouped the data based on attributes and also I joined two queries by using
  -- union to get the solutions for real time problems.
  
								-- Thank you --