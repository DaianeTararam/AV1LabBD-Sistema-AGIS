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
create table telefone(
ddd					int not null,
num					int not null,
usuarioCpf			char(11) not null
primary key(ddd, num, usuariocpf)
foreign key (usuarioCpf) references usuario(cpf)
)
go
create table funcionario(
usuarioCpf			char(11) not null
primary key(usuarioCpf)
foreign key usuarioCpf references usuario(cpf)
)
go
create table professor(
usuarioCpf			char(11) not null,
titulacaoProfessor	varchar(50) not null
primary key(usuarioCpf)
foreign key usuarioCpf references usuario(cpf)
)
go
create table curso(
codigoCurso			int identity(0, 1),
nomeCurso			varchar(30) not null,
cargaHorariaCurso	int not null,
siglaCurso			char(3) not null,
notaEnade			decimal(2,1) not null
primary key(codigoCurso)
)
go
create table aluno(
ra					int not null,
dataConclusao		date not null,
pontuacaoVestibular decimal(3,1) not null,
cursoCodigo			int not null,
usuarioCpf			char(11) not null
primary key(ra)
foreign key usuarioCpf references usuario(cpf),
foreign key cursoCodigo references curso(codigoCurso)
)
go
create table matricula(
idMatricula			int identity(10001, 1),
anoIngresso			int not null,
semestre			int not null,
anoLimiteGraduacao  int not null,
turno				varchar(25),
alunoRa				int not null
primary key (idMatricula)
foreign key alunoRa references aluno(ra)
)
go
create table disciplina (
codigoDisciplina	int identity(1001, 1),
nomeDisciplina		varchar(25) not null,
qtdeHorasSemanais	int not null,
professorUsuarioCpf	char(11) not null
primary key (codigoDisciplina)
foreign key professorUsuarioCpf references professor(usuarioCpf)
)
go
create table curso_disciplina(
idCursoDisciplina	int not null,
codigoCurso			int not null,
codigoDisciplina	int not null
primary key (idCursoDisciplina)
foreign key codigoCurso references curso(codigoCurso),
foreign key codigoDisciplina references disciplina(codigoDisciplina)
)
go
create table conteudo(
idConteudo			int not null,
nomeConteudo		varchar(25) not null,
codigoDisciplina	int not null
primary key (idConteudo)
foreign key codigoDisciplina references disciplina(codigoDisciplina)
)
go
create procedure sp_validaCpfRepetido (@cpf char(11), @saida varchar(10) output)
as
    if (@cpf = '00000000000' or
        @cpf = '11111111111' or
        @cpf = '22222222222' or
        @cpf = '33333333333' or
        @cpf = '44444444444' or
        @cpf = '55555555555' or
        @cpf = '66666666666' or
        @cpf = '77777777777' or
        @cpf = '88888888888' or
        @cpf = '99999999999')
    begin
        set @saida = 'invalido'
    end
    else
    begin
        set @saida = 'valido'
    end
go
create procedure sp_validadorCpf (@cpf char(11), @saida varchar(8) output)
as
    declare @d1 int, @d2 int, @d3 int, @d4 int, @d5 int, @d6 int, @d7 int, @d8 int,
            @d9 int, @d10 int, @d11 int, @dg1 int, @dg2 int, @saidaRepetido varchar(8)

	exec sp_validaCpfRepetido @cpf, @saidaRepetido output
    if (@saidaRepetido = 'invalido')
    begin
        set @saida = 'invalido'
        return
    end

    set @d1 = cast(substring(@cpf, 1, 1) as int)
    set @d2 = cast(substring(@cpf, 2, 1) as int)
    set @d3 = cast(substring(@cpf, 3, 1) as int)
    set @d4 = cast(substring(@cpf, 4, 1) as int)
    set @d5 = cast(substring(@cpf, 5, 1) as int)
    set @d6 = cast(substring(@cpf, 6, 1) as int)
    set @d7 = cast(substring(@cpf, 7, 1) as int)
    set @d8 = cast(substring(@cpf, 8, 1) as int)
    set @d9 = cast(substring(@cpf, 9, 1) as int)
    set @d10 = cast(substring(@cpf, 10, 1) as int)
    set @d11 = cast(substring(@cpf, 11, 1) as int)

    set @dg1 = (@d1*10 + @d2*9 + @d3*8 + @d4*7 + @d5*6 + @d6*5 + @d7*4 + @d8*3 + @d9*2) % 11
    if (@dg1 < 2)
    begin
        set @dg1 = 0
    end
    else
    begin
        set @dg1 = 11 - @dg1
    end

    set @dg2 = (@d1*11 + @d2*10 + @d3*9 + @d4*8 + @d5*7 + @d6*6 + @d7*5 + @d8*4 + @d9*3 + @dg1*2) % 11
    if (@dg2 < 2)
    begin
        set @dg2 = 0
    end
    else
    begin
        set @dg2 = 11 - @dg2
    end

    if (@dg1 = @d10 and @dg2 = @d11)
    begin
        set @saida = 'valido'
    end
    else
    begin
        set @saida = 'invalido'
    end
go
create procedure sp_validaIdade (@dataNascimento date, @saida varchar(8) output)
as
	declare @idade int
	set @idade = datediff(day, @dataNascimento, getdate())/ 365

	if (@idade >= 16)
	begin
		set @saida = 'valido'
	end
	else
	begin
		set @saida= 'invalido'
	end
go
create procedure sp_calculaGraduacao (@dataConclusao date output)
as
	set @dataConclusao = dateadd(year, 5, getdate())
go
create procedure sp_ra(@ra varchar(20) output)
as
	declare @ano varchar(4), @semestre varchar(1), @a varchar(4)
	set @ano = cast(year(getdate()) as varchar)
	
	if month(getdate()) <= 6
	begin
		set @semestre = '1'
	end
	else 
	begin
		set @semestre = '2'
	end

	set @a = right('0000' + cast(cast(rand()*10000 as int)as varchar), 4)
	set @ra = @ano + @semestre + @a
go
create procedure sp_matricular( @cpf char(11), @datanascimento date, @saida varchar(10) output)
as
	declare @valCpf varchar(8), @valIdade varchar(8),
		    @dataConclusao date, @ra varchar(20)
	
	--Validando o cpf
	exec sp_validadorCpf @cpf, @valCpf output
	if(@valCpf = 'invalido')
	begin
		set @saida = 'CPF inválido!'
		return
	end

	--Validando a idade
	exec  sp_validaIdade @dataNascimento, @valIdade output
	if(@valIdade = 'invalido')
	begin
		set @saida = 'Idade inválida!'
		return
	end

	exec sp_calculagraduacao @dataconclusao output

    exec sp_ra @ra output

	insert into aluno(ra, dataConclusao, usuarioCpf)
    values (@ra, @dataConclusao, @cpf)

    set @saida = 'Matrícula realizada com sucesso!'
go

