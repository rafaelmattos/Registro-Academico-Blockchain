// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "../contracts/Compartilhamento.sol";

contract CompartilhamentoTest {
    Compartilhamento compartilhamento;

    // Função de inicialização
    function beforeAll() public {
        compartilhamento = new Compartilhamento();
    }

    // Teste para criar uma solicitação de compartilhamento
    function testeSolicitarCompartilhamento() public {
        compartilhamento.solicitarCompartilhamento(1, "Informacoes compartilhadas");
        
        // Obter a solicitação de compartilhamento criada
        (address aluno, address destinatario, uint256 matricula, string memory informacoesCompartilhadas, bool aprovada) = compartilhamento.solicitacoesDeCompartilhamento(0);

        Assert.equal(aluno, address(this), "O aluno deve ser o endereco do contrato de teste");
        Assert.equal(destinatario, address(0), "O destinatario deve ser endereco vazio inicialmente");
        Assert.equal(matricula, 1, "A matricula deve ser 1");
        Assert.equal(informacoesCompartilhadas, "Informacoes compartilhadas", "As informacoes compartilhadas devem ser 'Informacoes compartilhadas'");
        Assert.equal(aprovada, false, "A solicitacao nao deve ser aprovada inicialmente");
    }

    // Teste para aprovar uma solicitação de compartilhamento
    function testeAprovarCompartilhamento() public {
        // Criar uma solicitação de compartilhamento
        compartilhamento.solicitarCompartilhamento(3, "Outras informacoes");

       

        // Aprovar a solicitação de compartilhamento
        compartilhamento.aprovarCompartilhamento(compartilhamento.obterNumeroDeSolicitacoes()-1);

        // Obter a solicitação de compartilhamento após a aprovação
        (address aluno, address destinatario, uint256 matricula, string memory informacoesCompartilhadas, bool aprovada) = compartilhamento.solicitacoesDeCompartilhamento(compartilhamento.obterNumeroDeSolicitacoes()-1);

        Assert.equal(aluno, address(this), "O aluno deve ser o endereco do contrato de teste");
        Assert.equal(destinatario, address(this), "O destinatario deve ser o endereco do contrato de teste apos a aprovacao");
        Assert.equal(matricula, 3, "A matricula deve ser 3");
        Assert.equal(informacoesCompartilhadas, "Outras informacoes", "As informacoes compartilhadas devem ser 'Outras informacoes'");
        Assert.equal(aprovada, true, "A solicitacao deve ser aprovada apos a aprovacao");
    }

    // Função de encerramento - chamada após todos os testes
    function afterAll() public {
        // Limpeza ou ações finais, se necessário
    }
}
