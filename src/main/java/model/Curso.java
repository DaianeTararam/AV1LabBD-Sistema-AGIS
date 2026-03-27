package model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class Curso {
	private int codigoCurso;
	private String nomeCurso;
	private int cargaHorariaCurso;
	private String siglaCurso;
	private float notaEnade;
	private List<Disciplina> disciplinas = new ArrayList<>();
	private List<Aluno> alunos = new ArrayList<>();
}
