USE mdinsider_poc;

DROP TABLE IF EXISTS provider_diagnoses;
CREATE TABLE IF NOT EXISTS provider_diagnoses LIKE provider_scores_nx_terms;
ALTER TABLE provider_diagnoses DISABLE KEYS;
INSERT INTO provider_diagnoses (npid, search_code, overall_score, median_score, background_score, experience_score)
SELECT npid, group_code, overall_score, median_score, background_score, experience_score FROM provider_experience WHERE group_type = 'DX';
ALTER TABLE provider_diagnoses DISABLE KEYS;

DROP TABLE IF EXISTS provider_procedures;
CREATE TABLE IF NOT EXISTS provider_procedures LIKE provider_scores_nx_terms;
ALTER TABLE provider_procedures DISABLE KEYS;
INSERT INTO provider_procedures (npid, search_code, overall_score, median_score, background_score, experience_score)
SELECT npid, group_code, overall_score, median_score, background_score, experience_score FROM provider_experience WHERE group_type = 'PX';
ALTER TABLE provider_procedures DISABLE KEYS;

DROP TABLE IF EXISTS provider_specialties;
CREATE TABLE IF NOT EXISTS provider_specialties LIKE provider_scores_nx_terms;
ALTER TABLE provider_specialties DISABLE KEYS;
INSERT INTO provider_specialties (npid, search_code, overall_score, median_score, background_score, experience_score)
SELECT npid, group_code, overall_score, median_score, background_score, experience_score FROM provider_experience WHERE group_type = 'SPX';
ALTER TABLE provider_specialties DISABLE KEYS;