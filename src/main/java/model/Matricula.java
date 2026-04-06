package model;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Matricula {
	private int idMatricula;
	private int anoIngresso;
	private int semestre;
	private int anoLimiteGraduacao;
	private String turno;
	private Aluno aluno;
	private Curso curso;
	List<Disciplina> disciplinas = new ArrayList<>();
}
