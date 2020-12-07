--trivia_question
delete from trivia_question;
ALTER TABLE trivia_question AUTO_INCREMENT = 1;
insert into trivia_question (question, correct_answer, other_answera, other_answerb, other_answerc) values 
("Who is the only other player other than Jamal Murray to score 50 on less than 24 field goal attempts?", "Bob Cousy", "Michael Jordan", "Lebron James", "Kareem Abdul Jabbar"),
("Who are the two players to have 25 point halves in a single playoff series?", "Jamal Murray/Allen Iverson", "James Harden/Russel Westbrook", "Michael Jordan/Kobe Bryant", "Steph Curry/Lebron James"),
("Who was the NBA’s first ever unanimous mvp", "Steph Curry", "Michael Jordan", "Shaquille O’Neal", "LeBron James"),
("Who was the youngest player to score 10,000 points?", "LeBron James", "Kobe Bryant", "Michael Jordan", "Kevin Durant"),
("Who scored the most points in a single NBA game?", "Wilt Chamberlain", "Kobe Bryant", "James Harden", "Michael Jordan"),
("What team has the worst W-L percentage in NBA history", "Minnesota Timberwolves", "Phoenix Suns", "Cleveland Cavaliers", "New York Knicks"),
("Who has the most Finals MVP’s?", "Michael Jordan", "Kareem Abdul Jabbar", "Magic Johnson", "Shaquille O’Neal"),
("What franchise has the most HOF’s to date?", "Boston Celtics", "Los Angeles Lakers", "Chicago Bulls", "San Antonio Spurs"),
("What was the name of Toronto’s first NBA team?", "Toronto Huskies", "Toronto Raptors", "Toronto Knickerbokers", "Toronto Grizzlies"),
("Who are the only two players in NBA history to average a triple double in a single season?", "Oscar Robertson/Russell Westbrook", "Oscar Robertson/Lebron James", "Magic Johnson/Russel Westbrook", "Luka Doncic/James Harden"),
("Who holds the record for most assists in a single game?","Scott Skiles- 30","Kevin Porter- 29","Magic Johnson- 32","John Stockton- 31"),
("What team drafted Kobe Bryant?","Charlotte Hornets","Los Angeles Lakers","Minnesota Timberwolves","Los Angeles Clippers"),
("What team did Kobe Bryant score 81 points against?","Toronto Raptors","Dallas Mavericks","Portland Trailblazers","Washington Wizards"),
("Who holds the record for most steals in a playoff game?","Allen Iverson","Manu Ginobli","Scottie Pippen","Gary Payton"),
("Draymond Green was selected with the ____ pick in the NBA draft.","35th","5th","20th","60th"),
("Youngest player to ever record a triple double in NBA history?","Markelle Fultz","Lebron James","Luka Doncic","Oscar Robertson"),
("What year was the NBA created?","1949","1952","1920","1961"),
("What university did Dwayne Wade attend?","Marquette","Duke","Boston College","Georgia Tech"),
("How many players to this date have made the jump from high school to the NBA?","44","22","10","75"),
("How many championship rings does the Laker franchise have?","16","18","15","11");

--debate_topic
delete from debate_topic;
ALTER TABLE debate_topic AUTO_INCREMENT = 1;
insert into debate_topic (active, tier, topic) values
(1, "Fanalyst", "Who is the greatest of all time?"),
(0, "Fanalyst", "Is Dwight Howard a HOF’er?"),
(1, "Fanalyst", "What should be the criteria for the HOF? Rings or accolades?"),
(0, "Fanalyst", "Is Carmelo Anthony a HOF’er?"),
(0, "Fanalyst", "Does Ja Morant win ROY if Zion plays a full season based on the numbers he put up in the games before and after the bubble?"),
(1, "Fanalyst", "Should college basketball players be paid?"),
(0, "Fanalyst", "Best team ever?"),
(0, "Fanalyst", "Who would you rather build around? Giannis Antetokounmpo or Ben Simmons?"),
(0, "Fanalyst", "Kyle Lowry or Russell Westbrook?"),
(0, "Fanalyst", "Should WNBA players be paid more?"),
(0, "Analyst", "Who is the greatest of all time?"),
(1, "Analyst", "In the modern era 1990-2020 who is the best coach? Phil Jackson or Gregg Popovich"),
(0, "Analyst", "Who’s A Better Point Guard: Kyrie, Steph, Westbrook or CP3?"),
(0, "Analyst", "Who was the real MVP Shaq or Kobe"),
(1, "Analyst", "What should be the criteria for the HOF? Rings or accolades?"),
(0, "Analyst", "Did Kobe Bryant deserve MVP in 2006-07 over Dirk?"),
(1, "Analyst", "Should college basketball players be paid?"),
(0, "Analyst", "Who was better of these two: Magic or Bird?"),
(0, "Analyst", "Is Chris Paul over or underrated?"),
(0, "Pro analyst", "Who is the greatest of all time?"),
(1, "Pro analyst", "Who’s A Better Point Guard: Kyrie, Steph, Westbrook or CP3?"),
(1, "Pro analyst", "What should be the criteria for the HOF? Rings or accolades?"),
(0, "Pro analyst", "Did Kobe Bryant deserve MVP in 2006-07 over Dirk?"),
(0, "Pro analyst", "Who is the best Centre to ever play basketball?"),
(0, "Pro analyst", "Should college basketball players be paid?"),
(0, "Pro analyst", "Who was better of these two: Magic or Bird?"),
(0, "Pro analyst", "Most underrated player ever?"),
(0, "Pro analyst", "Most overrated player ever?"),
(1, "Pro analyst", "Are Lebron’s teammates really that bad or are they never credited?"),
(0, "Expert analyst", "Who is the greatest of all time?"),
(1, "Expert analyst", "Who’s A Better Point Guard: Kyrie, Steph, Westbrook or CP3?"),
(0, "Expert analyst", "Which brand of basketball was better 1990-2005 or 2005-2020?"),
(0, "Expert analyst", "Is Carmelo Anthony a HOF’er?"),
(0, "Expert analyst", "Who was the real MVP Shaq or Kobe?"),
(1, "Expert analyst", "What should be the criteria for the HOF? Rings or accolades?"),
(0, "Expert analyst", "Who is the best Centre to ever play basketball?"),
(0, "Expert analyst", "Should college basketball players be paid?"),
(1, "Expert analyst", "Who was better of these two: Magic or Bird?"),
(0, "Expert analyst", "Most underrated player ever?"),
(0, "Expert analyst", "Most overrated player ever?"),
(0, "Expert analyst", "Are Lebron’s teammates that bad or are they never credited?")
;

--analyze_post
delete from analyze_post;
ALTER TABLE analyze_post AUTO_INCREMENT = 1;
insert into analyze_post (user_id, topic_id, created_time, rate_count, agree_rate, is_active, content) values
(8, 21, 1604764366286, 10, 52.13, 1, "This is analyze post 1"),
(7, 21, 1604765366286, 11, 43.22, 1, "This is analyze post 2"),
(10, 21, 1604766366286, 9, 77.77, 1, "This is analyze post 3"),
(9, 21, 1604767366286, 12, 99.99, 1, "This is analyze post 4 very long  long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long"),
(4, 22, 1604768366286, 30, 65, 1, "This is analyze post 5"),
(4, 29, 1604769366286, 40, 22.1, 1, "This is analyze post 6");

--analyze_post_agree

--comment
delete from comment;
ALTER TABLE comment AUTO_INCREMENT = 1;
insert into comment (post_id, post_type, user_id, created_time, like_count, content) values
(4, "openCourt", 6, 1604764366286, 13, "This is open court post 4 comment 1"),
(4, "openCourt", 8, 1604774366286, 5, "This is open court post 4 comment 2"),
(4, "openCourt", 7, 1604784366286, 34, "This is open court post 4 comment 3 very long  long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long");

--follow
delete from follow;
insert into follow (follower, followed) values
(4, 1),
(4, 3),
(4, 5),
(2, 4),
(3, 4),
(6, 4);

--likes

--open_court_post
delete from open_court_post;
ALTER TABLE open_court_post AUTO_INCREMENT = 1;
insert into open_court_post (user_id, like_count, created_time, content) values
(1, 9999, 1604554366286, "Post so long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long");

--subcomment
delete from subcomment;
ALTER TABLE subcomment AUTO_INCREMENT = 1;
insert into subcomment (comment_id, user_id, comment_to_user_id, created_time, like_count, content) values
(3, 1, 0, 1604794366286, 4, "This is open court post 4 comment 3 subcomment 1"),
(3, 5, 1, 1604804366286, 3, "This is open court post 4 comment 3 subcomment 2"),
(3, 2, 5, 1604814366286, 4, "This is open court post 4 comment 3 subcomment 3 very long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long");

--user
delete from user;
ALTER TABLE user AUTO_INCREMENT = 1;
insert into user (username, email, bio, favorite_sport, age, want_to_know_sport, favorite_sport_team, level_of_sport_play, acs_point, trivia_acs_point, debate_acs_point, picks_acs_point, participation_acs_point) values
("a", "a@a", "bio_aa", "favorite_sport_aa", 18, "want_to_know_sport_aa", "favorite_sport_team_aa", "level_of_sport_play_aa", 50, 50, 50, 50, 50),
("b", "b@b", "bio_bb", "favorite_sport_bb", 28, "want_to_know_sport_bb", "favorite_sport_team_bb", "level_of_sport_play_bb", 350, 350, 350, 350, 350),
("c", "c@c", "bio_cc", "favorite_sport_cc", 38, "want_to_know_sport_cc", "favorite_sport_team_cc", "level_of_sport_play_cc", 150, 150, 150, 150, 150),
("d", "d@d", "bio_dd", "favorite_sport_dd", 48, "want_to_know_sport_dd", "Lakers", "level_of_sport_play_dd", 250, 250, 250, 250, 250),
("e", "e@e", "bio_ee", "favorite_sport_ee", 8, "want_to_know_sport_ee", "favorite_sport_team_ee", "level_of_sport_play_ee", 550, 550, 550, 550, 550),
("f", "f@f", "bio_ff", "favorite_sport_ff", 58, "want_to_know_sport_ff", "favorite_sport_team_ff", "level_of_sport_play_ff", 450, 450, 450, 450, 450),
("g", "g@g", "bio_gg", "favorite_sport_gg", 48, "want_to_know_sport_gg", "favorite_sport_team_gg", "level_of_sport_play_gg", 220, 220, 220, 220, 220),
("h", "h@h", "bio_hh", "favorite_sport_hh", 48, "want_to_know_sport_hh", "favorite_sport_team_hh", "level_of_sport_play_hh", 230, 230, 230, 230, 230),
("i", "i@i", "bio_ii", "favorite_sport_ii", 48, "want_to_know_sport_ii", "favorite_sport_team_ii", "level_of_sport_play_ii", 240, 240, 240, 240, 240),
("j", "j@j", "bio_jj", "favorite_sport_jj", 48, "want_to_know_sport_jj", "favorite_sport_team_jj", "level_of_sport_play_jj", 260, 260, 260, 260, 260);

--pick_prediction_topic
delete from pick_prediction_topic;
ALTER TABLE pick_prediction_topic AUTO_INCREMENT = 1;
insert into pick_prediction_topic (content, op1, op2, op3, op4, op1num, op2num, op3num, op4num, answer_index, type) values
("", "LAL", "POR", null, null, 0, 0, null, null, 0, "playoff"),
("", "HOU", "OKC", null, null, 0, 0, null, null, 0, "playoff"),
("", "DEN", "UTA", null, null, 0, 0, null, null, 0, "playoff"),
("", "LAC", "DAL", null, null, 0, 0, null, null, 0, "playoff"),
("", "MIL", "ORL", null, null, 0, 0, null, null, 0, "playoff"),
("", "IND", "MIA", null, null, 0, 0, null, null, 1, "playoff"),
("", "BOS", "PHI", null, null, 0, 0, null, null, 0, "playoff"),
("", "TOR", "BRK", null, null, 0, 0, null, null, 0, "playoff"),
("", "LAL", "HOU", null, null, 0, 0, null, null, 0, "playoff"),
("", "DEN", "LAC", null, null, 0, 0, null, null, 0, "playoff"),
("", "MIL", "MIA", null, null, 0, 0, null, null, 1, "playoff"),
("", "BOS", "TOR", null, null, 0, 0, null, null, 0, "playoff"),
("", "LAL", "DEN", null, null, 0, 0, null, null, 0, "playoff"),
("", "MIA", "BOS", null, null, 0, 0, null, null, 0, "playoff"),
("", "LAL", "MIA", null, null, 0, 0, null, null, 0, "playoff"),
("content1", "op1", "op2", "op3", "op4", 1, 2, 3, 4, null, "prediction"),
("content2", "op1", "op2", null, null, 1, 2, null, null, null, "pick"),
("content3 long  long long long long long long long long long long long long long", "op1 long long long long long long", "op2", "op3", "op4", 1, 2, 3, 4, null, "prediction"),
("content4", "op1", "op2", null, null, 1, 2, null, null, null, "pick");

--pick_prediction_user_answer
delete from pick_prediction_user_answer;
ALTER TABLE pick_prediction_user_answer AUTO_INCREMENT = 1;

--acs_history
delete from acs_history;
ALTER TABLE acs_history AUTO_INCREMENT = 1;
insert into acs_history (user_id, time, change_amount, module, description) values
(4, 1604794366286, 2, "Participation", "Daily post reward"),
(4, 1604795366286, -2, "Trivia Head-to-head", "Lost head-to-head trivia game"),
(4, 1604796366286, 4, "Picks and Prediction", "Successful pick"),
(4, 1604797366286, 7, "Debate and Analyze", "Analyze got 66% agree rate"),
(4, 1604798366286, 4, "Trivia", "Got 4 points from trivia solo");

--user_auth
delete from user_auth;
ALTER TABLE user_auth AUTO_INCREMENT = 1;
insert into user_auth (user_id, type, identifier, hashed_credential) values
(1, "username", "a", "$2a$10$ooyqeFyiNY9lWdwTrRB60eGKgMRIwddwuA9WroTcUV9Nv5C6rSM6m"),
(1, "email", "a@a", "$2a$10$ooyqeFyiNY9lWdwTrRB60eGKgMRIwddwuA9WroTcUV9Nv5C6rSM6m"),
(2, "username", "b", "$2a$10$mh5h8NFbENusfRURHGf7Xue25SKrOc9EH3m8XCwt3vTwYjqsw7NzG"),
(2, "email", "b@b", "$2a$10$mh5h8NFbENusfRURHGf7Xue25SKrOc9EH3m8XCwt3vTwYjqsw7NzG"),
(3, "username", "c", "$2a$10$2oBCC74jZTy1CP9Vv7JYzuSW53UYTOIDeLqCFq4jAp5eZtZ4Qq72m"),
(3, "email", "c@c", "$2a$10$2oBCC74jZTy1CP9Vv7JYzuSW53UYTOIDeLqCFq4jAp5eZtZ4Qq72m"),
(4, "username", "d", "$2a$10$De1fLxwZJQvS2uVK16KCJ.lzkQKRBvdRVEg/ODLEU32lT2RT3gx.i"),
(4, "email", "d@d", "$2a$10$De1fLxwZJQvS2uVK16KCJ.lzkQKRBvdRVEg/ODLEU32lT2RT3gx.i"),
(5, "username", "e", "$2a$10$5dElGv.gDAIyyUjKAkQdyOOytnpFyeUqyae8BySRBAwl2460AQVvu"),
(5, "email", "e@e", "$2a$10$5dElGv.gDAIyyUjKAkQdyOOytnpFyeUqyae8BySRBAwl2460AQVvu"),
(6, "username", "f", "$2a$10$QS..m6HLFPlxUNcCEUTJaOiikcDH/3Qg57NOvt3htLVzOv5RoQ68e"),
(6, "email", "f@f", "$2a$10$QS..m6HLFPlxUNcCEUTJaOiikcDH/3Qg57NOvt3htLVzOv5RoQ68e"),
(7, "username", "g", "$2a$10$/CjUy1VX1NbRDSPbaoqUIe1u30euhyaTrvXJG.HX9Du149jypJ1ZC"),
(7, "email", "g@g", "$2a$10$/CjUy1VX1NbRDSPbaoqUIe1u30euhyaTrvXJG.HX9Du149jypJ1ZC"),
(8, "username", "h", "$2a$10$LGb4u8JvrOYvkroPK3xPYuftCW7yvg791b0HCKR6Ek8Pm9xGOK/Gm"),
(8, "email", "h@h", "$2a$10$LGb4u8JvrOYvkroPK3xPYuftCW7yvg791b0HCKR6Ek8Pm9xGOK/Gm"),
(9, "username", "i", "$2a$10$Dxw/8XJDE5h76GmplTsD5uMtM.mva1Ces3Po8FN3h.VQtUJpFlnmu"),
(9, "email", "i@i", "$2a$10$Dxw/8XJDE5h76GmplTsD5uMtM.mva1Ces3Po8FN3h.VQtUJpFlnmu"),
(10, "username", "j", "$2a$10$ckM3QKCivh4zcPZa8CAlPuLnkqmcVLBH5BBxE8PRKli9HFrtn8qIm"),
(10, "email", "j@j", "$2a$10$ckM3QKCivh4zcPZa8CAlPuLnkqmcVLBH5BBxE8PRKli9HFrtn8qIm");