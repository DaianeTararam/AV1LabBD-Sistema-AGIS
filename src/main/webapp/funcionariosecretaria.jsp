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
<title>Cadastro do aluno</title>
</head>
<body>
	<header>Página do Funcionário</header>
	    <div class="container mt-4" style="max-width: 600px;">
		    <h1>Gerenciar Alunos</h1>
		    
		    <form action="funcionarioSecretaria" method="post" class="card-agis">
		        <label for="ra" class="form-label">RA do Aluno</label>
		        <div class="d-flex gap-2 mb-3">
		            <input type="text" name="ra" id="ra" placeholder="Digite o RA para Buscar/Excluir"
		                   value='<c:out value="${aluno.ra}"/>'>
		            <button type="submit" name="botao" value="Buscar" class="btn-agis" style="background-color: var(--verde-claro);">🔍</button>
		        </div>
		
		        <hr>
		
		        <label for="cpf" class="form-label">Dados Pessoais</label>
		        <input type="text" maxlength="11" name="cpf" id="cpf" placeholder="CPF (somente números)"
		               value='<c:out value="${aluno.cpf}"/>' required>
		            
		        <input type="text" name="nome" id="nome" placeholder="Nome Completo"
		               value='<c:out value="${aluno.nome}"/>' required>
		      
		        <input type="text" name="nome_social" id="nome_social" placeholder="Nome Social"
		               value='<c:out value="${aluno.nomeSocial}"/>'>
		                
		        <label for="data_nascimento" class="form-label">Data de Nascimento</label>
		        <input type="date" name="data_nascimento" id="data_nascimento"
		               value='<c:out value="${aluno.dataNascimento}"/>' required>
		
		        <input type="email" name="email_pessoal" id="email_pessoal" placeholder="E-mail Pessoal"
		               value='<c:out value="${aluno.emailPessoal}"/>' required>
		        
		        <input type="email" name="email_corporativo" id="email_corporativo" placeholder="E-mail Corporativo"
		               value='<c:out value="${aluno.emailCorporativo}"/>'>
		
		        <label for="pontuacao_vestibular" class="form-label">Pontuação Vestibular (0.0 a 100.0)</label>
		        <input type="number" name="pontuacao_vestibular" id="pontuacao_vestibular"
		               placeholder="00.0" min="0" max="100" step="0.1"
		               value='<c:out value="${aluno.pontuacaoVestibular}"/>'>
		             
		        <label class="form-label">Telefone Principal</label>
		        <div class="row g-2 mb-3">
		            <div class="col-3">
		                <input type="number" name="ddd" placeholder="DDD" min="11" max="99" required>
		            </div>    
		            <div class="col-9">
		                <input type="number" name="num" placeholder="Número" required>
		            </div>   
		        </div>
		        
		        <label for="curso" class="form-label">Escolha o Curso</label>
				<select name="curso" class="form-select">
				    <option value="">Selecione um curso...</option>
				    <c:forEach var="c" items="${cursos}"> 
				        <option value="${c.codigoCurso}">${c.nome}</option>
				    </c:forEach>
				</select>
		
		        <div class="d-grid gap-2 d-md-flex justify-content-md-center mt-4">
		            <button type="submit" name="botao" value="Cadastrar" class="btn-agis">Cadastrar</button>
		            <button type="submit" name="botao" value="Atualizar" class="btn-agis">Atualizar</button>
		            <button type="submit" name="botao" value="Listar" class="btn-agis" style="background-color: var(--verde-claro);">Listar Todos</button>
		            <button type="submit" name="botao" value="Excluir" class="btn-agis" 
		                    style="background-color: #dc3545;" onclick="return confirm('Tem certeza que deseja excluir?')">Excluir</button>
		        </div>
		    </form>
		</div>
		<c:if test="${not empty alunos}">
		    <div align="center" class="card-agis mt-4">
		        <h3>Lista de Alunos</h3>
		        <table class="table table-striped table-bordered">
		            <thead class="table-success">
		                <tr>
		                    <th>RA</th>
		                    <th>CPF</th>
		                    <th>Nome</th>
		                    <th>Curso</th> <th>Data de Conclusão</th>
		                </tr>
		            </thead>
		            <tbody>
		                <c:forEach var="a" items="${alunos}">
		                    <tr>
		                        <td>${a.ra}</td>
		                        <td>${a.cpf}</td>
		                        <td>${a.nome}</td>
		                        <td>${a.curso.nome}</td> <td>${a.dataConclusao}</td>
		                    </tr>
		                </c:forEach>
		            </tbody>
		        </table>
		    </div>
		</c:if>
		<div style="background: yellow; padding: 10px;">
    DEBUG - Lista de Cursos: ${cursos} <br>
    DEBUG - Tamanho da Lista: ${cursos.size()}
</div>
	
</body>
	<footer>
		<p>Desenvolvido por: Daiane Tararam</p>
	</footer>
</html>