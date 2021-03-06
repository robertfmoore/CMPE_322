create database if not exists shelter_database;


create table if not exists shelter_database.locations(
  name varchar(40) not null,
  address varchar(100) not null,
  phone numeric(10,0) not null,
  type enum ('SPCA', 'SHELTER', 'RESCUE_ORG'),
  primary key(name)
);

create table if not exists shelter_database.shelters(
  name varchar(40) not null,
  website varchar(100) not null,
  owner varchar(40) not null,
  primary key(name),
  foreign key(name) references locations(name),
  foreign key(owner) references people(name)
);

create table if not exists shelter_database.rescue_orgs(
  name varchar(40) not null,
  owner varchar(40) not null,
  primary key(name),
  foreign key(name) references locations(name),
  foreign key(owner) references people(name)
);


create table if not exists shelter_database.animal_types(
  type varchar(40) not null,
  primary key(type)
);

create table if not exists shelter_database.accepted_animals(
  shelter_name varchar(40) not null,
  type varchar(40) not null,
  max_accepted int not null,
  primary key(shelter_name, type),
  foreign key(shelter_name) references locations(name),
  foreign key(type) references animal_types(type)
);

create table if not exists shelter_database.animals(
  uuid numeric(10,0) not null,
  type varchar(40) not null,
  location varchar(40) not null,
  arrival_date date not null,
  primary key(uuid),
  foreign key(location) references locations(name),
  foreign key(type) references animal_types(type)
);

create table if not exists shelter_database.people(
  name varchar(40) not null,
  phone numeric(10,0),
  address varchar(100),
--  type enum ("ADOPTER", "VET", "DRIVER", "EMPLOYEE", "DONOR"),
  primary key(name)
);

create table if not exists shelter_database.drivers(
  name varchar(40) not null,
  licence_num numeric(15,0) not null,
  licence_plate varchar(8) not null,
  workplace varchar(40) not null,
  primary key(name),
  foreign key(name) references people(name),
  foreign key(workplace) references locations(name)
  on delete cascade
  on update cascade
);

create table if not exists shelter_database.employees(
  name varchar(40) not null,
  workplace varchar(40) not null,
  primary key(name),
  foreign key(name) references people(name),
  foreign key(workplace) references locations(name)
);

create table if not exists shelter_database.vet_visits(
  vet varchar(40) not null,
  animal numeric(10,0) not null,
  visit_date date not null,
  weight numeric(5,2),
  reason varchar(200),
  primary key(vet, animal, visit_date),
  foreign key(vet) references people(name),
  foreign key(animal) references animals(uuid)
);

create table if not exists shelter_database.donations(
  donor varchar(40) not null,
  recipient varchar(40) not null,
  amount numeric(10,2) not null,
  date_transaction date,
  primary key(donor, recipient, date_transaction),
  foreign key(donor) references people(name),
  foreign key(recipient) references locations(name)
);

create table if not exists shelter_database.adoptions(
  animal_id numeric(10,0) not null,
  adopter_name varchar(40) not null,
  amount numeric(5,2) not null,
  adopt_date date not null,
  primary key(animal_id),
  foreign key(adopter_name) references people(name),
  foreign key(animal_id) references animals(uuid)
);

create table if not exists shelter_database.transfers(
  animal_id numeric(10,0) not null,
  driver varchar(40),
  amount_paid numeric(5,2) not null,
  transfer_date date not null,
  spca varchar(40) not null,
  destination varchar(40) not null,
  primary key(animal_id, transfer_date),
  foreign key(animal_id) references animals(uuid),
  foreign key(driver) references people(name),
  foreign key(spca) references locations(name),
  foreign key(destination) references locations(name)
);
