create table "__EFMigrationsHistory"
(
    "MigrationId"    varchar(150) not null
        constraint "PK___EFMigrationsHistory"
            primary key,
    "ProductVersion" varchar(32)  not null
);

alter table "__EFMigrationsHistory"
    owner to postgres;

create table "AspNetRoles"
(
    "Id"               bigint generated by default as identity
        constraint "PK_AspNetRoles"
            primary key,
    "CreatedBy"        bigint                   not null,
    "UpdatedBy"        bigint                   not null,
    "CreatedDate"      timestamp with time zone not null,
    "UpdatedDate"      timestamp with time zone not null,
    "Name"             varchar(256),
    "NormalizedName"   varchar(256),
    "ConcurrencyStamp" text
);

alter table "AspNetRoles"
    owner to postgres;

create unique index "RoleNameIndex"
    on "AspNetRoles" ("NormalizedName");

create table "AspNetUsers"
(
    "Id"                   bigint generated by default as identity
        constraint "PK_AspNetUsers"
            primary key,
    "FirstName"            text,
    "LastName"             text,
    "CreatedBy"            bigint                   not null,
    "UpdatedBy"            bigint                   not null,
    "CreatedDate"          timestamp with time zone not null,
    "UpdatedDate"          timestamp with time zone not null,
    "UserName"             varchar(256),
    "NormalizedUserName"   varchar(256),
    "Email"                varchar(256),
    "NormalizedEmail"      varchar(256),
    "EmailConfirmed"       boolean                  not null,
    "PasswordHash"         text,
    "SecurityStamp"        text,
    "ConcurrencyStamp"     text,
    "PhoneNumber"          text,
    "PhoneNumberConfirmed" boolean                  not null,
    "TwoFactorEnabled"     boolean                  not null,
    "LockoutEnd"           timestamp with time zone,
    "LockoutEnabled"       boolean                  not null,
    "AccessFailedCount"    integer                  not null
);

alter table "AspNetUsers"
    owner to postgres;

create index "EmailIndex"
    on "AspNetUsers" ("NormalizedEmail");

create unique index "UserNameIndex"
    on "AspNetUsers" ("NormalizedUserName");

create table "AspNetRoleClaims"
(
    "Id"         integer generated by default as identity
        constraint "PK_AspNetRoleClaims"
            primary key,
    "RoleId"     bigint not null
        constraint "FK_AspNetRoleClaims_AspNetRoles_RoleId"
            references "AspNetRoles"
            on delete cascade,
    "ClaimType"  text,
    "ClaimValue" text
);

alter table "AspNetRoleClaims"
    owner to postgres;

create index "IX_AspNetRoleClaims_RoleId"
    on "AspNetRoleClaims" ("RoleId");

create table "AspNetUserClaims"
(
    "Id"         integer generated by default as identity
        constraint "PK_AspNetUserClaims"
            primary key,
    "UserId"     bigint not null
        constraint "FK_AspNetUserClaims_AspNetUsers_UserId"
            references "AspNetUsers"
            on delete cascade,
    "ClaimType"  text,
    "ClaimValue" text
);

alter table "AspNetUserClaims"
    owner to postgres;

create index "IX_AspNetUserClaims_UserId"
    on "AspNetUserClaims" ("UserId");

create table "AspNetUserLogins"
(
    "LoginProvider"       text   not null,
    "ProviderKey"         text   not null,
    "ProviderDisplayName" text,
    "UserId"              bigint not null
        constraint "FK_AspNetUserLogins_AspNetUsers_UserId"
            references "AspNetUsers"
            on delete cascade,
    constraint "PK_AspNetUserLogins"
        primary key ("LoginProvider", "ProviderKey")
);

alter table "AspNetUserLogins"
    owner to postgres;

create index "IX_AspNetUserLogins_UserId"
    on "AspNetUserLogins" ("UserId");

create table "AspNetUserRoles"
(
    "UserId" bigint not null
        constraint "FK_AspNetUserRoles_AspNetUsers_UserId"
            references "AspNetUsers"
            on delete cascade,
    "RoleId" bigint not null
        constraint "FK_AspNetUserRoles_AspNetRoles_RoleId"
            references "AspNetRoles"
            on delete cascade,
    constraint "PK_AspNetUserRoles"
        primary key ("UserId", "RoleId")
);

alter table "AspNetUserRoles"
    owner to postgres;

create index "IX_AspNetUserRoles_RoleId"
    on "AspNetUserRoles" ("RoleId");

create table "AspNetUserTokens"
(
    "UserId"        bigint not null
        constraint "FK_AspNetUserTokens_AspNetUsers_UserId"
            references "AspNetUsers"
            on delete cascade,
    "LoginProvider" text   not null,
    "Name"          text   not null,
    "Value"         text,
    constraint "PK_AspNetUserTokens"
        primary key ("UserId", "LoginProvider", "Name")
);

alter table "AspNetUserTokens"
    owner to postgres;

