package model;

import java.math.BigDecimal;
import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Aluno extends Usuario{
	private String ra;
	private LocalDate dataConclusao;
	private BigDecimal pontuacaoVestibular;	
	private Curso curso;
}
