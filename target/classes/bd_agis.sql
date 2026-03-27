create database db_agis
go
use db_agis
go
create table usuario(
cpf					char(11) not null unique,
nome				varchar(70) not null,
nomeSocial			varchar(70) null,
dataNascimento		date not null,
emailPessoal		varchar(40) not null,
emailCorporativo	varchar(40) not null
primary key(cpf)
)
go
create table curso(
codigoCurso			int not null,
nomeCurso			varchar(30) not null,
cargaHorariaCurso	int not null,
siglaCurso			char(3) not null,
notaEnade			decimal(2,1) not null
primary key(codigoCurso)
)
go
create table matricula(
idMatricula			int not null,
anoIngresso			int not null,
semestre			int not null,
anoLimiteGraduacao  int not null
primary key (idMatricula)
)
go
create table telefone(
ddd					int not null,
num					int not null,
usuarioCpf			char(11) not null
primary key(ddd, num, usuariocpf)
foreign key (usuarioCpf) references usuario(cpf)
)
create table aluno(
ra					int not null,
dataConclusao		date not null,
pontuacaoVestibular decimal(3,1) not null,
turno				varchar(20)
primary key(ra)
)
