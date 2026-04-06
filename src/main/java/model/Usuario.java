package model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Usuario {
	private String cpf;
	private String nome;
	private String nomeSocial;
	private LocalDate dataNascimento;
	private String emailPessoal;
	private String emailCorporativo;
	private List<Telefone> telefones = new ArrayList<>();
}
