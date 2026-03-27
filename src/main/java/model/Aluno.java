package model;

import java.time.LocalDate;
import lombok.Data;


@Data
public class Aluno extends Usuario{
	private int ra;
	private LocalDate dataConclusao;
	private float pontuacaoVestibular;	
	private Curso curso;
}
