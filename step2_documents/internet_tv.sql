-- 上書き設定
DROP DATABASE IF EXISTS internet_tv;
CREATE DATABASE IF NOT EXISTS internet_tv;
USE internet_tv;

DROP TABLE IF EXISTS channels,
                     programs,
                     time_tables,
                     episodes,
                     seasons,
                     genres,
                     program_genre;

-- テーブル定義
-- チャンネル (channels) テーブル
CREATE TABLE channels (
    channel_id INT NOT NULL AUTO_INCREMENT,
    channel_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (channel_id),
    INDEX (channel_name)
);

-- 番組 (programs) テーブル
CREATE TABLE programs (
    program_id INT NOT NULL AUTO_INCREMENT,
    program_title VARCHAR(50) NOT NULL,
    program_detail TEXT,
    episode_id INT NOT NULL, -- エピソードテーブルの外部キー
    PRIMARY KEY (program_id),
    INDEX (program_title)
);

-- タイムテーブル (time_tables) テーブル
CREATE TABLE time_tables (
    timetable_id INT NOT NULL AUTO_INCREMENT,
    program_id INT NOT NULL, -- 番組テーブルの外部キー
    viewership_count INT NOT NULL,
    air_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    channel_id INT NOT NULL, -- チャンネルテーブルの外部キー
    PRIMARY KEY (timetable_id)
);

-- エピソード (episodes) テーブル
CREATE TABLE episodes (
    episode_id INT NOT NULL AUTO_INCREMENT,
    episode_title VARCHAR(50) NOT NULL,
    episode_number INT NOT NULL,
    episode_detail TEXT,
    video_duration TIME NOT NULL,
    release_date DATE,
    season_id INT, -- シーズンテーブルの外部キー
    PRIMARY KEY (episode_id),
    INDEX (episode_title),
    INDEX (episode_number)
);

-- シーズン (seasons) テーブル
CREATE TABLE seasons (
    season_id INT NOT NULL AUTO_INCREMENT,
    season_title VARCHAR(50) NOT NULL,
    season_number INT,
    episode_total_number INT NOT NULL,
    PRIMARY KEY (season_id),
    INDEX (season_title),
    INDEX (season_number)
);

-- ジャンル (genres) テーブル
CREATE TABLE genres (
    genre_id INT NOT NULL AUTO_INCREMENT,
    genre_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (genre_id),
    INDEX (genre_name)
);

-- 番組とジャンルの中間テーブル (episode_genre) テーブル
CREATE TABLE program_genre (
    program_genre_id INT NOT NULL AUTO_INCREMENT,
    program_id INT NOT NULL, -- プログラムテーブルの外部キー
    genre_id INT NOT NULL, -- ジャンルテーブルの外部キー
    PRIMARY KEY (program_genre_id)
);

source ./test_data/load_program_genre.dump ;
source ./test_data/load_channels.dump ;
source ./test_data/load_episodes.dump ;
source ./test_data/load_genres.dump ;
source ./test_data/load_programs.dump ;
source ./test_data/load_seasons.dump ;
source ./test_data/load_time_tables.dump ;

-- 外部キー設定
ALTER TABLE programs
    ADD FOREIGN KEY (episode_id) REFERENCES episodes(episode_id) ON DELETE CASCADE;

ALTER TABLE time_tables
    ADD FOREIGN KEY (program_id) REFERENCES programs(program_id) ON DELETE CASCADE,
    ADD FOREIGN KEY (channel_id) REFERENCES channels(channel_id) ON DELETE CASCADE;

ALTER TABLE episodes
    ADD FOREIGN KEY (season_id) REFERENCES seasons(season_id) ON DELETE CASCADE;

ALTER TABLE program_genre
    ADD FOREIGN KEY (program_id) REFERENCES programs(program_id) ON DELETE CASCADE,
    ADD FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE;
