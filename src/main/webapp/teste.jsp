<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="style.css" />
<title>Insert title here</title>
</head>
<body>
	<div align="center" class="container">
		<form action="matricula" method="post">
			<p class="title">
				<b class="cadastrar">Realize a Matrícula</b>
			</p>
			<table>
				<tr>
					<td class="aluno">
						<p class="title">Codigo:</p> <input class="cadastro" type="number"
						id="codigo" name="codigo" placeholder=""
						value='<c:out value="${matricula.codigo }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td class="aluno"><label for="curso">Aluno:</label></td>
					<td><select class="input_data" id="aluno" name="aluno">
							<option value="">Selecione o Aluno</option>
							<c:forEach var="aluno" items="${alunos}">
								<option value="${aluno.cpf}">${aluno.nome}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr class="espaco">
					<td class="aluno"><label for="disciplina">Disciplina:</label></td>
					<td><select class="input_data" id="disciplina"
						name="disciplina">
							<option value="">Selecione uma Disciplina</option>
							<c:forEach var="disciplina" items="${disciplinas}">
								<option value="${disciplina.codigo}">${disciplina.nome}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td class="aluno">
						<p class="title">Data da Matrícula:</p> <input class="cadastro"
						type="date" id="data_m" name="data_m"
						value='<c:out value="${matricula.data_m }"></c:out>'>
					</td>
				</tr>
				<tr class="espaco">
					<td class="aluno"><label for="status">Status:</label></td>
					<td><select class="input_data" id="status" name="status">
							<option value="">Selecione o Status</option>
							<c:forEach var="status" items="${statuss }">
								<option value="${status.nome}">${status.nome}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr class="botoes">
					<td><input type="submit" name="botao" value="Cadastrar"></td>
					<td><input type="submit" name="botao" value="Alterar"></td>
					<td><input type="submit" name="botao" value="Excluir"></td>
					<td><input type="submit" name="botao" value="Listar"></td>
				</tr>
			</table>
		</form>
	</div>
	<div align="center">
		<c:if test="${not empty erro}">
			<h2>
				<b><c:out value="${erro}" /></b>
			</h2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida}">
			<h3>
				<b><c:out value="${saida}" /></b>
			</h3>
		</c:if>
	</div>
	<div align="center">
		<c:choose>
			<c:when test="${not empty tipoTabela && tipoTabela eq 'Listar'}">
				<c:if test="${not empty matriculas }">
					<table class="table_round">
						<thead>
							<tr>
								<th>Codigo</th>
								<th>Aluno</th>
								<th>Disciplina</th>
								<th>Data Matrícula</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="matricula" items="${matriculas }">
								<tr>
									<td><c:out value="${matricula.codigo}" /></td>
									<td><c:out value="${matricula.aluno.nome}" /></td>
									<td><c:out value="${matricula.disciplina.nome}" /></td>
									<td><c:out value="${matricula.data }" /></td>
									<td><c:out value="${matricula.status.nome}" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
			</c:when>
		</c:choose>
	</div>
</body>
</html>