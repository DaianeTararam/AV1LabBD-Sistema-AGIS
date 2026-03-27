package model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class Aluno extends Usuario{
	private int ra;
	private LocalDate dataConclusao;
	private float pontuacaoVestibular;
	private String turno;
	private List<Telefone> telefones = new ArrayList<>();
	
}
