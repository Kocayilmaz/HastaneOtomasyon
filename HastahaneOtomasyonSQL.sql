USE HastaneOtomasyonDB

CREATE TABLE Kullanici(
KullaniciID int identity PRIMARY KEY NOT NULL,
KullaniciAdi varchar(25) NOT NULL,
KullaniciSifre varchar(20) NOT NULL,
KullaniciTur char(3) NOT NULL
CONSTRAINT ck_KullaniciTur
CHECK (KullaniciTur in ('DOK','VEZ','LAB'))
)

CREATE TABLE Klinik(
KlinikID tinyint identity PRIMARY KEY NOT NULL,
KlinikAdi varchar(30) NOT NULL,
)

CREATE TABLE  Doktor(
 DoktorID int identity PRIMARY KEY NOT NULL,
 KlinikID tinyint 
 CONSTRAINT fk_KlinikID_DoktorTB
 FOREIGN KEY (KlinikID) references Klinik(KlinikID) NOT NULL,

DoktorTC tinyint UNIQUE NOT NULL
CONSTRAINT ck_DoktorTC
CHECK(LEN(DoktorTC) = 11),

 DoktorAd varchar(25) NOT NULL,
 DoktorSoyad varchar(20) NOT NULL,
 DoktorCinsiyet char(1) NOT NULL
 CONSTRAINT ck_DoktorCinsiyet
 CHECK(DoktorCinsiyet in ('E', 'K')),

 DoktorDogumTarihi date 
 CONSTRAINT ck_DoktorDogumTarihi
 CHECK(DoktorDogumTarihi<=getdate()),
)

CREATE TABLE Hasta(
HastaID int identity(1,1) PRIMARY KEY,

HastaTC tinyint UNIQUE NOT NULL
CONSTRAINT ck_HastaTC
CHECK(LEN(HastaTC) = 11),

HastaAd varchar(25) NOT NULL ,
HastaSoyad varchar(20) NOT NULL ,
HastaBabaAdi varchar(20),
HastaAnneAdi varchar(20),

HastaCepTel varchar(10) NOT NULL
CONSTRAINT ck_HastaCepTel
CHECK(LEN(HastaCepTel) = 10),

HastaPosta varchar(50),
HastaAdres nvarchar(max),
HastaDogum date,

HastaCinsiyet char(1) NOT NULL
CONSTRAINT ck_HastaCinsiyet
CHECK (HastaCinsiyet in ('E','K')),

HastaKanGrup varchar(3) NOT NULL
CONSTRAINT ck_KanGrup 
CHECK(HastaKanGrup in ('A+','B+','A-','B-','0-','0+','AB-','AB+'))
)

CREATE TABLE Laboratuvar(
LabID tinyint identity(1,1) PRIMARY KEY,
LabAdi varchar(50) NOT NULL
)

CREATE TABLE Tani(
TaniID int identity(1,1) PRIMARY KEY,
TaniAdi varchar(50),
TaniAciklama nvarchar(50)
)

CREATE TABLE Test(
TestID int PRIMARY KEY,

HastaID int
CONSTRAINT fk_HastaID_TestTB
FOREIGN KEY (HastaID) REFERENCES Hasta(HastaID),

LabID tinyint
CONSTRAINT fk_LabID_TestTB
FOREIGN KEY (LabID) REFERENCES Laboratuvar(LabID),

TaniID int
CONSTRAINT fk_TaniID_TestTB
FOREIGN KEY (TaniID) REFERENCES Tani(TaniID)
)

CREATE TABLE Randevu(
RandevuID int identity(1,1) PRIMARY KEY,

HastaID int 
CONSTRAINT fk_HastaID_RandevuTB
FOREIGN KEY (HastaID) REFERENCES Hasta(HastasID),

RandevuDoktorID int 
CONSTRAINT fk_RandevuDoktorID_RandevuTB
FOREIGN KEY (RandevuDoktorID) REFERENCES Doktor(DoktorID),

KlinikID tinyint
CONSTRAINT fk_KlinikID_RandevuTB
FOREIGN KEY (KlinikID) REFERENCES Klinik(KlinikID),

RandevuTarih date,
)