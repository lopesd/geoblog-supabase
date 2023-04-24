ALTER TABLE peeps DROP COLUMN checkin_id;
ALTER TABLE checkins DROP COLUMN chapter_id;

-- Update chapters table
ALTER TABLE chapters
  ALTER COLUMN chapter_id TYPE UUID using (uuid_generate_v4()),
  ALTER COLUMN chapter_id SET DEFAULT uuid_generate_v4();

-- Update checkins table
ALTER TABLE checkins
  ALTER COLUMN checkin_id TYPE UUID USING (uuid_generate_v4()),
  ALTER COLUMN checkin_id SET DEFAULT uuid_generate_v4(),
  ADD COLUMN chapter_id UUID NOT NULL references chapters on delete cascade not null;

-- Update peeps table
ALTER TABLE peeps
  ALTER COLUMN peep_id TYPE UUID USING (uuid_generate_v4()),
  ALTER COLUMN peep_id SET DEFAULT uuid_generate_v4(),
  ADD COLUMN checkin_id UUID NOT NULL references checkins on delete cascade;

-- Update subscribers table
ALTER TABLE subscribers
  ALTER COLUMN subscriber_id TYPE UUID USING (uuid_generate_v4()),
  ALTER COLUMN subscriber_id SET DEFAULT uuid_generate_v4();