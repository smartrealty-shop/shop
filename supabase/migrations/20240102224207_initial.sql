--
-- CITIES
--
create table if not exists public.cities
(
  slug varchar(255) primary key,
  name varchar(255) not null
);

-- Set up Row Level Security (RLS)
-- See https://supabase.com/docs/guides/auth/row-level-security for more details.
alter table cities
  enable row level security;

create policy "Cities are viewable by everyone." on cities
  for select using (true);

comment on table public.cities is 'Table of Cities, where SmartRealty tracks things';
comment on column public.cities.slug is 'Unique identifier inside SmartRealty, also for URL usage';
comment on column public.cities.name is 'Human-readible name of City';

--
-- DEVELOPERS
--

create table if not exists public.developers
(
  slug varchar(255) primary key,
  name text not null,
  url text not null
);

comment on table public.developers is 'Table of Developers, known to SmartRealty';
comment on column public.developers.slug is 'Unique identifier inside SmartRealty, also for URL usage';
comment on column public.developers.name is 'String of Developer official name';
comment on column public.developers.url is 'Simple string that leads to developer''s website';

alter table developers
  enable row level security;

create policy "Developers are viewable by everyone." on developers
  for select using (true);

--
-- DISTRICTS
--
create table public.districts
(
    slug      varchar(255) not null
        primary key,
    city_slug varchar(255) not null
        references public.cities
            on update cascade on delete restrict,
    name      varchar(255) not null,
    unique (city_slug, slug)
);

comment on table public.districts is 'Table of Districts, where known to SmartRealty Units resides';
comment on column public.districts.slug is 'Unique identifier inside SmartRealty, also for URL usage';
comment on column public.districts.city_slug is 'FK to City';
comment on column public.districts.name is 'Human-readible name of City’s District';

alter table districts
  enable row level security;

create policy "Districts are viewable by everyone." on districts
  for select using (true);

--
-- COMPLEXES
--

create table public.complexes
(
    id                uuid default gen_random_uuid() not null
        primary key,
    district_slug     varchar(255)                 not null
        constraint complexes_districts_slug_fk
            references public.districts
            on update cascade on delete restrict,
    developer_slug    varchar(255)                 not null
        references public.developers
            on update cascade on delete restrict,
    name              text                         not null,
    description       text                         not null,
    w3w               text                         not null,
    coordinates       point                        not null,
    completed_at      text                         not null,
    status            text                         not null,
    -- with_apartments   boolean    default false,
    -- with_villas       boolean    default false,
    -- with_townhouses   boolean    default false,
    -- floors_b          numeric                      not null,
    -- floors_c          numeric                      not null,
    -- floors_g          numeric    default 1         not null,
    -- floors_p          numeric                      not null,
    -- floors_r          numeric    default 1         not null,
    -- has_gym           boolean    default false,
    -- has_pool          boolean    default false,
    -- has_sauna         boolean    default false,
    -- has_kindergarden  boolean    default false,
    -- has_garden        boolean    default false,
    -- has_court         boolean    default false,
    -- has_workspace     boolean    default false,
    -- has_jogging_track boolean    default false,
    -- has_retail_outlet boolean    default false,
    -- has_yoga_space    boolean    default false,
    is_furnished      boolean    default false
);

comment on table public.complexes is 'Table of Complexes, where known to SmartRealty Units resides';
comment on column public.complexes.district_slug is 'Slug района города';
comment on column public.complexes.developer_slug is 'Slug of Developer which is unique PK';
comment on column public.complexes.name is 'Building complex name';
comment on column public.complexes.description is 'Marketing details from Developer';
comment on column public.complexes.w3w is 'Geolocation of Complex entrance in what3words format';
comment on column public.complexes.coordinates is 'Содержит геолокацию, выраженную в широте+долготе';
comment on column public.complexes.completed_at is 'Date when Complex would be open for owners';
comment on column public.complexes.status is 'Current status of units in Complex for investors/buyers';
-- comment on column public.complexes.with_apartments is 'True if there is apartments in Complex';
-- comment on column public.complexes.with_villas is 'True if there is villas in Complex';
-- comment on column public.complexes.with_townhouses is 'True if there is townhouses in Complex';
-- comment on column public.complexes.floors_b is 'Amount of basement floors';
-- comment on column public.complexes.floors_c is 'Amount of common floors';
-- comment on column public.complexes.floors_g is 'Amount of ground floors';
-- comment on column public.complexes.floors_p is 'Amount of basement floors';
-- comment on column public.complexes.floors_r is 'Amount of roof floors';

alter table complexes
  enable row level security;

create policy "Complexes are viewable by everyone." on complexes
  for select using (true);

--
-- BUILDINGS
--

create table public.buildings
(
    id              uuid default gen_random_uuid() not null
        primary key,
    complex_id      uuid                   not null
        references public.complexes,
    name            varchar(255)                 not null,
    type            varchar(25)                  not null,
    floors_basement integer    default 0         not null,
    floors_common   integer    default 1         not null,
    floors_ground   integer    default 1         not null,
    floors_parking  integer    default 0         not null,
    floors_roof     integer    default 0         not null
);

comment on table public.buildings is 'Table of Buildings, where known to SmartRealty Units resides';
comment on column public.buildings.type is 'Тип Здания — многоквартирный (апартаменты), вилла или ещё что-то';
comment on column public.buildings.floors_basement is 'Количество подвальных этажей';
comment on column public.buildings.floors_common is 'Количество жилых этажей с квартирами';
comment on column public.buildings.floors_ground is 'Число ground этажей — там обычно находится лобби и инфраструктура вроде магазинчиков';
comment on column public.buildings.floors_parking is 'Число этажей с парковкой';
comment on column public.buildings.floors_roof is 'Число этажей "крыши" — не технический этаж, а доступное жителям пространство';

alter table buildings
  enable row level security;

create policy "Buildings are viewable by everyone." on buildings
  for select using (true);

--
-- UNITS
--

create table public.units
(
    id          uuid default gen_random_uuid() not null primary key,
    building_id uuid                           not null references public.buildings,
    type        text                         not null,
    bedrooms    text                         not null,
    area        numeric                      not null,
    price       numeric(10, 2)               not null,
    floor       integer,
    number      integer,
    unique (building_id, number)
);

comment on table public.units is 'Table of Units like flats, apartments and villas';
comment on column public.units.id is 'Уникальный ID Юнита';
comment on column public.units.building_id is 'id Строения, к которому относится Юнит';
comment on column public.units.type is 'Тип Юнита: 1 — апартаменты, 2 — таунхаус, 3 - вилла';
comment on column public.units.bedrooms is 'Количество спален';
comment on column public.units.area is 'Площадь Юнита в квадратных футах';
comment on column public.units.price is 'Стоимость Юнита в AED';
comment on column public.units.floor is 'Этаж, где расположен Юнит';
comment on column public.units.number is 'Уникальный номер Юнита (номер квартры или виллы)';

alter table units
  enable row level security;

create policy "Units are viewable by everyone." on units
  for select using (true);
