<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<link rel="stylesheet" href="style.css" />
<title>AGIS</title>
</head>
<body>
	<header>Seja bem-vindo(a)</header>
		<div class="container text-center mt-5">
			<h1 class="mb-4">Sistema AGIS</h1>
		<form action="EscolhaUsuario" method="post">
			<div class="mb-3">
            <label class="form-label">Escolha o tipo de usuário</label>
            <select name="tipoUsuario" class="form-select">
                <option value="">Selecione...</option>
                <option value="Matricula">Aluno</option>
                <option value="professor">Professor</option>
                <option value="funcionarioSecretaria">Funcionário da Secretaria</option>
            </select>
        </div>

        <input type="submit"
        id="botao" name="botao" value="Continuar"
        class="btn-agis">
			
		</form>
	</div>
	<footer>
		<p>Desenvolvido por: Daiane Tararam</p>
	</footer>
</body>
</html>