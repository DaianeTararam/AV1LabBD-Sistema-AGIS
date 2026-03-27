<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<title>AGIS</title>
<script>
	function continuar(){
		var tipo = document.getElementById()
	}
</script>
</head>
<body>
	<p class="titulo">Seja bem-vindo ao Sistema AGIS</p>
	<form action="EscolhaUsuario" method="post">
	<div>	
	<label for="tipoUsuario">Escolha o seu tipo de usuário</label>
	<select id="tipoUsuario" name="tipoUsuario" class="form-select form-select-sm">
		<option value="">Selecione...</option>
		<option value="aluno">Aluno</option>
		<option value="professor">Professor</option>
		<option value="funcionarioSecretaria">Funcionário da Secretaria</option>
	</select>
	<table>
		<tr>
			<td>
				<input type="submit"
				id="botao" name="botao" value="Continuar"
				class="btn btn-danger">
			</td>
		</tr>
	</table>
	</div>
	</form>
</body>
</html>