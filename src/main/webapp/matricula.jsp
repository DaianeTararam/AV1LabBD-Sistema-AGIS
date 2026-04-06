<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="style.css" />
<title>Matrícula</title>
</head>
<body>
	<header>Página do aluno</header>
	<main>
		<div class="container mt-4" style="max-width: 600px;">
		  <div class="card-agis">
		    <h1>Realizar Matrícula</h1>
		    <form action="matricula" method="post">
		      
		      <div class="mb-3">
		        <label for="aluno_ra" class="form-label">RA do Aluno</label>
		        <input type="text" id="aluno_ra" name="aluno_ra" placeholder="Digite seu RA" required>
		      </div>
		
		      <div class="mb-3">
		        <label for="codigo_disciplina" class="form-label">Escolha a Disciplina</label>
		        <select name="codigo_disciplina" id="codigo_disciplina" required>
		            <option value="">Selecione uma disciplina...</option>
		            <c:forEach var="d" items="${disciplinasDisponiveis}">
		                <option value="${d.codigoDisciplina}">${d.nome}</option>
		            </c:forEach>
		            <option value="1005">Disciplina 5</option>
		        </select>
		      </div>
		
		      <div class="d-flex gap-2 mt-3">
		        <button type="submit" name="botao" value="Matricular" class="btn-agis">Matricular</button>
		        <button type="submit" name="botao" value="Listar" class="btn-agis" style="background-color: var(--verde-claro);">Listar Matérias</button>
		      </div>
		    </form>
		  </div>
		</div>
		
		<div class="container mt-3" style="max-width: 600px;">
		    <c:if test="${not empty saida}">
		        <div class="alert alert-success" style="background-color: var(--verde-claro); color: white; border: none;">
		            ${saida}
		        </div>
		    </c:if>
		    <c:if test="${not empty erro}">
		        <div class="alert alert-danger" style="background-color: #f8d7da; color: #721c24;">
		            ${erro}
		        </div>
		    </c:if>
		</div>
		<c:if test="${not empty matriculas}">
		    <div class="container mt-4 card-agis">
		        <h3 style="color: var(--verde-escuro); font-family: 'Arial black';">Minhas Disciplinas</h3>
		        <table class="table table-hover">
		            <thead>
		                <tr>
		                    <th>Disciplina</th>
		                    <th>Dia</th>
		                    <th>Início</th>
		                </tr>
		            </thead>
		            <tbody>
		                <c:forEach var="m" items="${matriculas}">
		                    <tr>
		                        <td>${m.disciplinas[0].nome}</td>
		                        <td>${m.disciplinas[0].diaSemana}</td>
		                        <td>${m.disciplinas[0].horaInicio}</td>
		                    </tr>
		                </c:forEach>
		            </tbody>
		        </table>
		    </div>
		</c:if>
	

	
	</main>
	<footer>
		<p>Desenvolvido por: Daiane Tararam</p>
	</footer>
</body>
</html>