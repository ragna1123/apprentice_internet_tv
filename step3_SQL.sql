-- 1. よく見られているエピソードを知りたいです。
-- エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください
-- SQL
SELECT
    p.program_title,
    t.viewership_count
FROM
    time_tables t
LEFT JOIN
    programs p ON t.program_id = p.program_id
ORDER BY
    t.viewership_count DESC
LIMIT 3;
-- SQL END

-- 2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。
-- エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください
-- SQL
SELECT
    p.program_title,
    s.season_num,
    e.episode_number,
    e.episode_title
FROM
    time_tables t
LEFT JOIN
    programs p ON t.program_id = p.program_id
LEFT JOIN
    episodes e ON e.episode_id = p.episode_id
LEFT JOIN
    seasons s ON s.season_id = e.season_id
ORDER BY
    t.viewership_count DESC
LIMIT 3;
-- SQL END

-- 3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。
-- 本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、
-- エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします
-- 本日 = 2023-11-11とします
-- SQL
SELECT
    c.channel_name,
    t.air_time,
    t.end_time,
    s.season_number,
    e.episode_number,
    e.episode_title,
    e.episode_detail
FROM
    time_tables t
LEFT JOIN
    channels c ON c.channel_id = t.channel_id
LEFT JOIN
    programs p ON t.program_id = p.program_id
LEFT JOIN
    episodes e ON e.episode_id = p.episode_id
LEFT JOIN
    seasons s ON s.season_id = e.season_id
WHERE
    t.air_time LIKE '2023-11-11%';
-- SQL END

-- 4. ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、
-- 本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、
-- 放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください
-- 本日 = 2023-11-11とします
-- SQL
SELECT
    t.air_time,
    t.end_time,
    s.season_number,
    e.episode_number,
    e.episode_title,
    e.episode_detail
FROM
    time_tables t
LEFT JOIN
    channels c ON c.channel_id = t.channel_id
LEFT JOIN
    programs p ON t.program_id = p.program_id
LEFT JOIN
    episodes e ON e.episode_id = p.episode_id
LEFT JOIN
    seasons s ON s.season_id = e.season_id
WHERE
    c.channel_name LIKE 'ドラマ' AND t.air_time 
BETWEEN
    '2023-11-11 00:00:00' AND '2023-11-18 00:00:00';
-- SQL END

-- 5. (advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、
-- エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください
-- 本日 = データの都合上2023-11-13とします
-- SQL
SELECT
    p.program_title,
    MAX(t.viewership_count) AS max_view,
    t.timetable_id
FROM
    time_tables t
LEFT JOIN
    programs p ON t.program_id = p.program_id
LEFT JOIN
    episodes e ON e.episode_id = p.episode_id
WHERE
    t.air_time
BETWEEN
    '2023-11-08 00:00:00' AND '2023-11-13 00:00:00'
GROUP BY
    t.timetable_id
ORDER BY
    max_view DESC
LIMIT 2;
-- SQL END

-- 1. (advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。
-- 番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。
-- ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。
-- SQL
SELECT
    g.genre_id,
    g.genre_name,
    AVG(t.viewership_count) AS avg_view
FROM
    time_tables t
LEFT JOIN
    programs p ON t.program_id = p.program_id
LEFT JOIN
    program_genre pg ON p.program_id = pg.program_id
LEFT JOIN
    genres g ON pg.genre_id = g.genre_id
WHERE

GROUP BY
    g.genre_id
ORDER BY
    avg_view DESC;
-- SQL END