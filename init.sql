-- test db用
-- dev は rake db:seedを実行する

BEGIN TRANSACTION

INSERT INTO prefectures (id, name, created_at, updated_at)
VALUES (1, '北海道', current_timestamp, current_timestamp) UNION ALL
VALUES (2, '青森県', current_timestamp, current_timestamp) UNION ALL
VALUES (3, '岩手県', current_timestamp, current_timestamp) UNION ALL
VALUES (4, '宮城県', current_timestamp, current_timestamp) UNION ALL
VALUES (5, '秋田県', current_timestamp, current_timestamp) UNION ALL
VALUES (6, '山形県', current_timestamp, current_timestamp) UNION ALL
VALUES (7, '福島県', current_timestamp, current_timestamp) UNION ALL
VALUES (8, '茨城県', current_timestamp, current_timestamp) UNION ALL
VALUES (9, '栃木県', current_timestamp, current_timestamp) UNION ALL
VALUES (10, '群馬県', current_timestamp, current_timestamp) UNION ALL
VALUES (11, '埼玉県', current_timestamp, current_timestamp) UNION ALL
VALUES (12, '千葉県', current_timestamp, current_timestamp) UNION ALL
VALUES (13, '東京都', current_timestamp, current_timestamp) UNION ALL
VALUES (14, '神奈川県', current_timestamp, current_timestamp) UNION ALL
VALUES (15, '新潟県', current_timestamp, current_timestamp) UNION ALL
VALUES (16, '富山県', current_timestamp, current_timestamp) UNION ALL
VALUES (17, '石川県', current_timestamp, current_timestamp) UNION ALL
VALUES (18, '福井県', current_timestamp, current_timestamp) UNION ALL
VALUES (19, '山梨県', current_timestamp, current_timestamp) UNION ALL
VALUES (20, '長野県', current_timestamp, current_timestamp) UNION ALL
VALUES (21, '岐阜県', current_timestamp, current_timestamp) UNION ALL
VALUES (22, '静岡県', current_timestamp, current_timestamp) UNION ALL
VALUES (23, '愛知県', current_timestamp, current_timestamp) UNION ALL
VALUES (24, '三重県', current_timestamp, current_timestamp) UNION ALL
VALUES (25, '滋賀県', current_timestamp, current_timestamp) UNION ALL
VALUES (26, '京都府', current_timestamp, current_timestamp) UNION ALL
VALUES (27, '大阪府', current_timestamp, current_timestamp) UNION ALL
VALUES (28, '兵庫県', current_timestamp, current_timestamp) UNION ALL
VALUES (29, '奈良県', current_timestamp, current_timestamp) UNION ALL
VALUES (30, '和歌山県', current_timestamp, current_timestamp) UNION ALL
VALUES (31, '鳥取県', current_timestamp, current_timestamp) UNION ALL
VALUES (32, '島根県', current_timestamp, current_timestamp) UNION ALL
VALUES (33, '岡山県', current_timestamp, current_timestamp) UNION ALL
VALUES (34, '広島県', current_timestamp, current_timestamp) UNION ALL
VALUES (35, '山口県', current_timestamp, current_timestamp) UNION ALL
VALUES (36, '徳島県', current_timestamp, current_timestamp) UNION ALL
VALUES (37, '香川県', current_timestamp, current_timestamp) UNION ALL
VALUES (38, '愛媛県', current_timestamp, current_timestamp) UNION ALL
VALUES (39, '高知県', current_timestamp, current_timestamp) UNION ALL
VALUES (40, '福岡県', current_timestamp, current_timestamp) UNION ALL
VALUES (41, '佐賀県', current_timestamp, current_timestamp) UNION ALL
VALUES (42, '長崎県', current_timestamp, current_timestamp) UNION ALL
VALUES (43, '熊本県', current_timestamp, current_timestamp) UNION ALL
VALUES (44, '大分県', current_timestamp, current_timestamp) UNION ALL
VALUES (45, '宮崎県', current_timestamp, current_timestamp) UNION ALL
VALUES (46, '鹿児島県', current_timestamp, current_timestamp) UNION ALL
VALUES (47, '沖縄県', current_timestamp, current_timestamp);


-- ミュージックカテゴリ
INSERT INTO music_categories (id, name, created_at, updated_at)
VALUES (1, 'JPOP', current_timestamp, current_timestamp) UNION ALL
VALUES (2, 'POP', current_timestamp, current_timestamp) UNION ALL
VALUES (3, 'METAL', current_timestamp, current_timestamp);

-- ミュージシャン
INSERT INTO affected_musicians (id, name, created_at, updated_at)
VALUES (1, 'Dir en grey', current_timestamp, current_timestamp) UNION ALL
VALUES (2, 'YUI', current_timestamp, current_timestamp) UNION ALL
VALUES (3, 'SAKANAMON', current_timestamp, current_timestamp);

-- related instrument
-- 楽器
INSERT INTO instrument_types(id, name, created_at, updated_at)
VALUES (1, 'Vocal', current_timestamp, current_timestamp) UNION ALL
VALUES (2, 'Guitar', current_timestamp, current_timestamp) UNION ALL
VALUES (3, 'Base', current_timestamp, current_timestamp) UNION ALL
VALUES (4, 'Drum', current_timestamp, current_timestamp);

-- 機材
INSERT INTO equipment(id, name, instrument_type_id, created_at, updated_at)
VALUES (1, 'マイク',  1, current_timestamp, current_timestamp) UNION ALL
VALUES (2, 'Fender', 2, current_timestamp, current_timestamp) UNION ALL
VALUES (3, 'ベース',  3, current_timestamp, current_timestamp) UNION ALL
VALUES (4, 'DW9000', 4, current_timestamp, current_timestamp);

-- 特殊スキル
INSERT INTO special_skills(id, name, instrument_type_id, created_at, updated_at)
VALUES (1, 'ボーカルスキル', 1,  current_timestamp, current_timestamp) UNION ALL
VALUES (2, 'ギタースキル',   2,  current_timestamp, current_timestamp) UNION ALL
VALUES (3, 'ベーススキル',   3,  current_timestamp, current_timestamp) UNION ALL
VALUES (4, 'ドラムスキル',   4,  current_timestamp, current_timestamp);

-- 楽器関連のuser 情報
-- 楽器
INSERT INTO instruments (id, experience, live_experience, skill_level, position, user_id, instrument_type_id ,created_at, updated_at)
VALUES (1, 1, 2, 3, 1, 2, 1, current_timestamp, current_timestamp);

-- 機材
INSERT INTO instrument_to_equipments (id, instrument_id, equipment_id, created_at, updated_at)
VALUES (1,1,1,current_timestamp, current_timestamp)

-- 特殊スキル
INSERT INTO instrument_to_special_skills (id, instrument_id, special_skill_id, created_at, updated_at)
VALUES (1,1,1,current_timestamp, current_timestamp)

-- ライブ経験
INSERT INTO live_experiences (type, created_at, updated_at)
VALUES('経験無し' ,current_timestamp, current_timestamp) UNION ALL
VALUES('1 ~ 10 回' ,current_timestamp, current_timestamp) UNION ALL
VALUES('11 ~ 30 回' ,current_timestamp, current_timestamp) UNION ALL
VALUES('31 ~ 50 回' ,current_timestamp, current_timestamp) UNION ALL
VALUES('51 回 以上' ,current_timestamp, current_timestamp)

COMMIT TRANSACTION
