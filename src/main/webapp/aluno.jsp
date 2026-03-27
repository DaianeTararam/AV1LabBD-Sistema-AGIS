<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Matrícula do aluno</title>
<link rel="stylesheet" href="style.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

</head>
<body>
	<div class="conteiner" align="center">
		<br />
		<br />
		<h1 class="titulo">Cadastro do aluno</h1>
		<br />
		<h3>Insira os dados do aluno:</h3>
		<form action="aluno" method="post">
			<table>
				<tr>
					<td colspan="4">
						<input type="number" 
						id="ra" name ="ra" placeholder="RA"
						value='<c:out value="${aluno.ra}"/>'
						class="input-group input-group-lg">
					</td>
				</tr>
				
				<tr>
					<td colspan="4">
						<input type="date"
						id="dataConclusao" name ="dataConclusao"
						value='<c:out value="${aluno.dataConclusao}"/>'
						class="input-group input-group-lg">
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<input type="number" max="100.0"
						id="pontuacaoVestibular" name ="pontuacaoVestibular" placeholder="Pontuação do vestibular"
						value='<c:out value="${aluno.pontuacaoVestibular}"/>'
						class="input-group input-group-lg">
					</td>
				</tr>
				
				<tr>
					<td colspan="4">
						<select id="turno" name="turno" class="form-select form-select-sm">
							<option value="">Selecione o turno...</option>
							<option value="turno">manhã</option>
							<option value="turno">tarde</option>
							<option value="turno">noite</option>
						</select>
					</td>
				</tr>	
			</table>
			<br />
					<td>
						<input type="submit"
						id="botao" name="botao" value="Inserir"
						class="btn btn-secondary">
					</td>								
					<td>
						<input type="submit"
						id="botao" name="botao" value="Atualizar"
						class="btn btn-secondary">
					</td>
					<td>
						<input type="submit"
						id="botao" name="botao" value="Listar"
						class="btn btn-secondary">
					</td>								
					<td>
						<input type="submit"
						id="botao" name="botao" value="Excluir"
						class="btn btn-secondary">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>