create table if not exists location(
  name varchar(40) not null,
  address varchar(100) not null,
  phone char(10) not null,
  type enum ('SPCA', 'SHELTER', 'RESCUE_ORG'),
  primary key(name)
);

create table if not exists shelters(
  name varchar(40) not null,
  website varchar(100) not null,
  owner varchar(40) not null,
  primary key(name),
  foreign key(name) references location(name),
  foreign key(owner) references people(name)
);

create table if not exists accepted_animals(
  shelter_name varchar(40) not null,
  type varchar(40) not null,
  max_accepted int not null,
  primary key(shelter_name, type),
  foreign key(shelter_name) references location(name)
);

create table if not exists animals(
  uuid char(10) not null,
  type varchar(40) not null,
  location varchar(40) not null,
  arrival_date date not null,
  primary key(uuid)
  foreign key(location) references location(name),
);

create table if not exists people(
  name varchar(40) not null,
  phone char(10),
  address varchar(100),
--  type enum ("ADOPTER", "VET", "DRIVER", "EMPLOYEE", "DONOR"),
  primary key(name),
  foreign key(workplace) references location(name)
);

create table if not exists drivers(
  name varchar(40) not null,
  licence_num char(15) not null,
  licence_plate varchar(8) not null,
  workplace varchar(40) not null,
  primary key(name),
  foreign key(name) references people(name),
  foreign key(workplace) references location(name)
);

create table if not exists employees(
  name varchar(40) not null,
  workplace varchar(40) not null,
  primary key(name),
  foreign key(name) references people(name),
  foreign key(workplace) references location(name)
);

create table if not exists vet_visits(
  vet varchar(40) not null,
  animal char(10) not null,
  visit_date date not null,
  weight numeric(4,2),
  reason varchar(200),
  primary key(vet, animal, visit_date),
  foreign key(vet) references people(name),
  foreign key(animal) references animals(uuid)
);

create table if not exists donations(
  donor varchar(40) not null,
  recipient varchar(40) not null,
  amount numeric(10,2) not null,
  date_transaction date,
  primary key(donor, recipient, date_transaction),
  foreign key(donor) references people(name),
  foreign key(recipient) references location(name)
);

create table if not exists adoptions(
  animal_id varchar(40) not null,
  adopter_name varchar(40) not null,
  amount numeric(5,2) not null,
  adopt_date date not null,
  primary key(animal_id),
  foreign key(adopter_name) references people(name),
  foreign key(animal_id) references animals(uuid)
);

create table if not exists transfers(
  animal_id varchar(40) not null,
  driver varchar(40),
  amount_paid numeric(5,2) not null,
  transfer_date date not null,
  source varchar(40) not null, --SPCA
  destination varchar(40) not null, --SHELTER
  primary key(animal_id, transfer_date),
  foreign key(animal_id) references animals(uuid),
  foreign key(driver) references people(name),
  foreign key(source) references location(name),
  foreign key(destination) references location(name)
);
