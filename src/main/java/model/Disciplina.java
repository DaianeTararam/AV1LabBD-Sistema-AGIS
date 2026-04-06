package model;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Disciplina {
	private int codigoDisciplina;
	private String nomeDisciplina;
	private int qtdeHorasSemanais;
	private List<Conteudo> conteudos = new ArrayList<>();
}
