// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "../contracts/Verificacao.sol";

contract VerificacaoTest {
    Verificacao verificacao;

    // Função de inicialização
    function beforeAll() public {
        verificacao = new Verificacao();
    }

// Teste para verificar a emissão do evento
function testeVerificarRegistro() public {
    // Adicionar um registro para teste
    verificacao.adicionarRegistro(
        address(this), // instituicao
        "Nome do Aluno", 
        1, // matricula
        "Curso Teste", 
        80, // nota
        true // emitido
    );

    // Chamar a função verificarRegistro para emitir o evento
    bool resultado = verificacao.verificarRegistro(1);

    // Verificar se o evento foi emitido
    Assert.equal(resultado, true, "O registro deve ser verificado");

    // Obter o registro verificável
    (address instituicao, string memory nomeAluno, uint256 matricula, string memory curso, uint256 nota, bool emitido) = verificacao.registrosVerificaveis(1);

    // Verificar os valores do registro
    Assert.equal(matricula, 1, "A matricula no registro deve ser 1");
    Assert.equal(nomeAluno, "Nome do Aluno", "O nome do aluno no registro deve ser 'Nome do Aluno'");
    Assert.equal(instituicao, address(this), "A instituicao no registro deve ser o endereco do contrato de teste");
    // Adicione verificações adicionais conforme necessário para outros campos
}

    // Função de encerramento - chamada após todos os testes
    function afterAll() public {
        // Limpeza ou ações finais, se necessário
    }
}
