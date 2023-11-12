# INTERNET_TV DATABASE 作成手順書
## データベースの作成手順
1. GitHubにて任意のディレクトリへクローンして下さい。
2. クローンしたファイルの`./internet_tv/step2_documents`へ移動してください
3. データベースを作成します。テーブル、テストデータも同時に作成されます。  
4. 空のテーブルを作成する場合は、`./internet_tv/step2_documents/internet_tv.sql`内の85-91行に存在するsource文をコメントアウトまたは、削除して下さい。
5. `mysql -u [任意のユーザー名] -p < internet_tv.sql`を権限を持ったユーザーで実行して下さい。
6. 加筆修正する場合は`./internet_tv/step2_documents/internet_tv.sql` SQLが記載されています。
7. テストデータは`./internet_tv/step2_documents/test_data`内に保存されています

## テーブル概要
チャンネル (channels)
| カラム名       | データ型  | NULL  | キー | 初期値 | AUTO INCREMENT |
|----------------|----------|-------|-----|--------|-----------------|
| channel_id     | INT      |       | PK  |        | YES             |
| channel_name   | VARCHAR(20) |       | INDEX |        |                 |

番組 (programs)
| カラム名         | データ型  | NULL  | キー | 初期値 | AUTO INCREMENT |
|------------------|----------|-------|-----|--------|-----------------|
| program_id       | INT      |       | PK  |        | YES             |
| program_title    | VARCHAR(50) |     | INDEX |        |                 |
| program_detail   | TEXT     | OK    |     |        |                 |
| episode_id       | INT      |       | FK  |        |                 |

タイムテーブル (time_tables)
| カラム名         | データ型  | NULL  | キー | 初期値 | AUTO INCREMENT |
|------------------|----------|-------|-----|--------|-----------------|
| timetable_id    | INT      |       | PK  |        | YES             |
| program_id       | INT      |       | FK  |        |                 |
| viewership_count | INT      |       |     |        |                 |
| air_time         | DATETIME |       |     |        |                 |
| end_time         | DATETIME |       |     |        |                 |
| channel_id       | INT      |       | FK  |        |                 |

エピソード (episodes)
| カラム名           | データ型  | NULL  | キー | 初期値 | AUTO INCREMENT |
|--------------------|----------|-------|-----|--------|-----------------|
| episode_id         | INT      |       | PK  |        | YES             |
| episode_title      | VARCHAR(50) |       | INDEX |        |                 |
| episode_number     | INT      |       | INDEX |        |                 |
| episode_detail     | TEXT     | OK    |     |        |                 |
| video_duration     | TIME     |       |     |        |                 |
| release_date       | DATE     | OK    |     |        |                 |
| genre_id           | INT      | OK    | FK  |        |                 |
| season_id          | INT      | OK    | FK  |        |                 |

シーズン (seasons)
| カラム名       | データ型  | NULL  | キー | 初期値 | AUTO INCREMENT |
|----------------|----------|-------|-----|--------|-----------------|
| season_id      | INT      |       | PK  |        | YES             |
| seasson_title  | VARCHAR(20)|     | INDEX |        |                 |
| season_num     | VARCHAR(20) |    | INDEX |        |                 |
| episode_total_num  | INT  |       |     |        |                 |
| season_genres | INT       |       |     |        |                 |

ジャンル (genres)
| カラム名       | データ型  | NULL  | キー | 初期値 | AUTO INCREMENT |
|----------------|----------|-------|-----|--------|-----------------|
| genre_id       | INT      |       | PK  |        | YES             |
| genre_name     | VARCHAR(20) |       | INDEX |        |                 |


シーズンとジャンルの中間テーブル (season_genre)
| カラム名           | データ型  | NULL  | キー | 初期値 | AUTO INCREMENT |
|--------------------|----------|-------|-----|--------|-----------------|
| season_genre_id   | INT      |       | PK  |        | YES             |
| episode_id         | INT      |       | FK  |        |                 |
| genre_id           | INT      |       | FK  |        |                 |
