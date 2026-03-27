package model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class Disciplina {
	private int codigoDisciplina;
	private String nomeDisciplina;
	private int qtdeHorasSemanais;
	private List<Conteudo> conteudos = new ArrayList<>();
}
