create database db_agis
go
use db_agis
go

CREATE LOGIN agis_user WITH PASSWORD = 'Agis@2026'
go
CREATE USER agis_user FOR LOGIN agis_user
go
EXEC sp_addrolemember 'db_owner', 'agis_user'
go

create table usuario(
cpf					char(11) not null unique,
nome				varchar(70) not null,
nome_social			varchar(70) null,
data_nascimento		date not null,
email_pessoal		varchar(40) not null,
email_corporativo	varchar(40) not null
primary key(cpf)
)
go
create table telefone(
ddd					int not null,
num					int not null,
usuario_cpf			char(11) not null
primary key(ddd, num, usuario_cpf)
foreign key (usuario_cpf) references usuario(cpf)
)
go
create table funcionario(
usuario_cpf			char(11) not null
primary key(usuario_cpf)
foreign key (usuario_cpf) references usuario(cpf)
)
go
create table professor(
usuario_cpf			char(11) not null,
titulacao       	varchar(50) not null
primary key(usuario_cpf)
foreign key (usuario_cpf) references usuario(cpf)
)
go 
insert into usuario(cpf, nome, data_nascimento, email_pessoal, email_corporativo) values
('02023743292', 'Leticia Rodrigues', '1989-03-25', 'legues@pessoal.com', 'legues@corporativo.com'),
('08860655501', 'Bruno Araújo', '1955-04-03', 'braujo@pessoal.com', 'braujo@corporativo.com'),
('95234051447', 'Maya Assis', '1983-03-09', 'massis@pessoal.com', 'massis@corporativo.com')
go
insert into professor(usuario_cpf, titulacao)values
('02023743292', 'Mestrado'),
('08860655501', 'Mestrado'),
('95234051447', 'Doutorado')
go
create table curso(
codigo_curso		int identity(0, 1),
nome_curso			varchar(30) not null,
carga_horaria_curso	int not null,
sigla_curso			char(3) not null,
nota_enade			decimal(2,1) not null
primary key(codigo_curso)
)
insert into curso(nome_curso, carga_horaria_curso, sigla_curso, nota_enade) values
('Curso A', 3000, 'CSA', 4.3),
('Curso B', 3000, 'CSB', 4.4),
('Curso C', 3000, 'CSC', 4.9),
('Curso D', 3000, 'CSD', 5.0),
('Curso E', 3000, 'CSE', 4.3),
('Curso F', 3000, 'CSF', 4.8),
('Curso G', 3000, 'CSG', 4.5),
('Curso H', 3000, 'CSH', 4.3),
('Curso I', 3000, 'CSI', 4.0)
go
create table aluno(
ra					varchar(20) not null,
data_conclusao		date not null,
pontuacao_vestibular decimal(3,1) not null,
curso_codigo		int not null,
usuario_cpf			char(11) not null
primary key(ra)
foreign key (usuario_cpf) references usuario(cpf),
foreign key (curso_codigo) references curso(codigo_curso)
)
go
create table disciplina (
codigo_disciplina	int identity(1001, 1),
nome_disciplina		varchar(50) not null,
qtde_horas_semanais	int not null,
professor_usuario_cpf	char(11) not null
primary key (codigo_disciplina)
foreign key (professor_usuario_cpf) references professor(usuario_cpf)
)
go
insert into disciplina(nome_disciplina, qtde_horas_semanais, professor_usuario_cpf) values
('Disciplina 1', 4, '02023743292'),
('Disciplina 2', 4, '02023743292'),
('Disciplina 3', 4, '08860655501'),
('Disciplina 4', 2, '02023743292'),
('Disciplina 5', 4, '08860655501'),
('Disciplina 6', 2, '02023743292'),
('Disciplina 7', 4, '08860655501'),
('Disciplina 8', 2, '95234051447'),
('Disciplina 9', 2, '95234051447'),
('Disciplina 10', 4, '95234051447')
go
create table matricula(
id_matricula		int identity(10001, 1),
ano_ingresso		int not null,
semestre			int not null,
ano_limite_graduacao int not null,
turno				varchar(25) not null,
aluno_ra			varchar(20) not null,
codigo_curso		int not null,
codigo_disciplina   int not null
primary key (id_matricula)
foreign key (codigo_curso) references curso(codigo_curso),
foreign key (aluno_ra) references aluno(ra),
foreign key (codigo_disciplina) references disciplina(codigo_disciplina)
)
create table curso_disciplina(
id_curso_disciplina	int identity(30001, 1),
codigo_curso		int not null,
codigo_disciplina	int not null
primary key (id_curso_disciplina)
foreign key (codigo_curso) references curso(codigo_curso),
foreign key (codigo_disciplina) references disciplina(codigo_disciplina)
)
go
insert into curso_disciplina(codigo_curso, codigo_disciplina) values
(0, 1001),
(0, 1002),
(1, 1003),
(1, 1004),
(2, 1005),
(2, 1006),
(3, 1007),
(3, 1008),
(4, 1009),
(4, 1010),
(5, 1001),
(6, 1002),
(7, 1009)
go
create table conteudo(
id_conteudo			int not null,
nome_conteudo		varchar(50) not null,
codigo_disciplina	int not null
primary key (id_conteudo)
foreign key (codigo_disciplina) references disciplina(codigo_disciplina)
)
go
create table horario (
id_horario			int identity(1,1),
dia_semana			varchar(15) not null, 
hora_inicio			time not null,
hora_fim			time not null,
codigo_disciplina	int not null,
primary key (id_horario),
foreign key (codigo_disciplina) references disciplina(codigo_disciplina)
)
go
insert into horario (dia_semana, hora_inicio, hora_fim, codigo_disciplina) values 
('Segunda-Feira', '13:00', '16:30', 1001),
('Terça-Feira', '13:00', '14:40', 1001),
('Quarta-Feira', '14:50', '18:20', 1001),
('Quinta-Feira', '14:50', '16:30', 1001),
('Sexta-Feira', '16:40', '18:20', 1001)
go
create procedure sp_valida_cpf_repetido (@cpf char(11), @saida varchar(10) output)
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
create procedure sp_validador_cpf (@cpf char(11), @saida varchar(8) output)
as
    declare @d1 int, @d2 int, @d3 int, @d4 int, @d5 int, @d6 int, @d7 int, @d8 int,
            @d9 int, @d10 int, @d11 int, @dg1 int, @dg2 int, @saida_repetido varchar(8)

	exec sp_valida_cpf_repetido @cpf, @saida_repetido output
    if (@saida_repetido = 'invalido')
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
create procedure sp_valida_idade (@data_nascimento date, @saida varchar(8) output)
as
	declare @idade int
	set @idade = datediff(day, @data_nascimento, getdate())/ 365

	if (@idade >= 16)
	begin
		set @saida = 'valido'
	end
	else
	begin
		set @saida= 'invalido'
	end
go
create procedure sp_calcula_graduacao (@data_conclusao date output)
as
	set @data_conclusao = dateadd(year, 5, getdate())
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
create procedure sp_aluno  @cod char(1), @cpf char(11), @nome varchar(70), @nome_social varchar(70) = null,
				 @data_nascimento date, @email_pessoal varchar(40),
				 @email_corporativo varchar(40), @data_conclusao date,
				 @pontuacao_vestibular decimal(3,1), @curso_codigo int,
				 @ddd int = null, @num int = null, @saida varchar(100) output
as	
	declare @ra varchar(20)
    declare @val_cpf varchar(8), @val_idade varchar(8)

    if (upper(@cod) = 'I')
    begin
        exec sp_validador_cpf @cpf, @val_cpf output
        if (@val_cpf = upper('invalido')) 
        begin
            set @saida = 'CPF inválido!'
            return
        end

        exec sp_valida_idade @data_nascimento, @val_idade output
        if (@val_idade = upper('invalido')) 
        begin
            set @saida = 'Idade inválida!'
            return
        end

        exec sp_ra @ra output
        exec sp_calcula_graduacao @data_conclusao output

        insert into usuario(cpf, nome, nome_social, data_nascimento, email_pessoal, email_corporativo)
        values (@cpf, @nome, @nome_social, @data_nascimento, @email_pessoal, @email_corporativo)

        insert into aluno (ra, data_conclusao, pontuacao_vestibular, curso_codigo, usuario_cpf)
        values (@ra, @data_conclusao, @pontuacao_vestibular, @curso_codigo, @cpf)

        if (@ddd is not null and @num is not null)
        begin
            insert into telefone (ddd, num, usuario_cpf)
            values (@ddd, @num, @cpf)
        end

        set @saida = 'Aluno inserido com sucesso!'
    end
	else
	if (upper(@cod) = 'U')
	begin
		update usuario 
		set nome = @nome, nome_social = @nome_social, 
			data_nascimento = @data_nascimento, email_pessoal = @email_pessoal,
			email_corporativo = @email_corporativo
		where cpf = @cpf

		update aluno 
		set pontuacao_vestibular = @pontuacao_vestibular, 
			curso_codigo = @curso_codigo
		where usuario_cpf = @cpf

		delete from telefone where usuario_cpf = @cpf
        if (@ddd is not null and @num is not null)
        begin
            insert into telefone (ddd, num, usuario_cpf)
            values (@ddd, @num, @cpf)
        end

		set @saida = 'Aluno atualizado com sucesso!'
	end
	else
	if (upper(@cod) = 'D')
	begin
		delete from telefone where usuario_cpf = @cpf

		delete from aluno where usuario_cpf = @cpf

		delete from usuario where cpf = @cpf

		set @saida = 'Aluno excluído do banco de dados!'
	end
	else 
	begin
		set @saida = 'Operação inválida!'
	end
go
create procedure sp_matricula_disciplina @ra varchar(20),  @codigo_disciplina int, @saida varchar(100) output
as
    declare @curso_aluno int
    select @curso_aluno = curso_codigo from aluno where ra = @ra

    if not exists (select 1 from curso_disciplina where codigo_curso = @curso_aluno and codigo_disciplina = @codigo_disciplina)
    begin
        set @saida = 'Esta disciplina não pertence ao seu curso.'
        return
    end

    if exists (
        select 1 
        from matricula m
        join horario h_existente on m.codigo_disciplina = h_existente.codigo_disciplina
        join horario h_nova on h_nova.codigo_disciplina = @codigo_disciplina -- Comparação direta
        where m.aluno_ra = @ra 
        and h_existente.dia_semana = h_nova.dia_semana
        and (h_nova.hora_inicio < h_existente.hora_fim and h_nova.hora_fim > h_existente.hora_inicio)
    )
    begin
        set @saida = 'Conflito de horário!'
        return
    end

    insert into matricula (aluno_ra, codigo_disciplina, ano_ingresso, semestre, turno, codigo_curso, ano_limite_graduacao)
    values (@ra, @codigo_disciplina, year(getdate()), (case when month(getdate()) <= 6 then 1 else 2 end),
            'Vespertino', @curso_aluno, year(getdate()) + 5)

    set @saida = 'Matrícula confirmada com sucesso!'
go
create procedure sp_listar_matricula @ra varchar(20)
as
begin
    select d.codigo_disciplina, d.nome_disciplina, d.qtde_horas_semanais,
           h.dia_semana, h.hora_inicio, h.hora_fim
    from matricula m
    join curso_disciplina cd on m.codigo_curso = cd.codigo_curso
    join disciplina d on cd.codigo_disciplina = d.codigo_disciplina
    join horario h on d.codigo_disciplina = h.codigo_disciplina
    where m.aluno_ra = @ra
end
go

declare @saida varchar(100)
exec sp_aluno 'I', '00716588072', 'Maria Silva', null, '2000-05-10',
              'maria@pessoal.com', 'maria@corp.com', null, 85.5,2, 11, 98765432, @saida output
select @saida


