// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "../contracts/RegistroAcademico.sol";

contract RegistroAcademicoTest {
    RegistroAcademico registroAcademico;

    // Funcao de inicializacao
    function beforeAll() public {
        registroAcademico = new RegistroAcademico();
    }

    // Teste para conceder permissao de emissao
    function testeConcederPermissaoDeEmissao() public {
        registroAcademico.concederPermissaoDeEmissao(address(this));
        Assert.equal(registroAcademico.permissoesDeEmissao(address(this)), true, "Permissao nao concedida corretamente.");
    }

    // Teste para revogar permissao de emissao
    function testeRevogarPermissaoDeEmissao() public {
        registroAcademico.revogarPermissaoDeEmissao(address(this));
        Assert.equal(registroAcademico.permissoesDeEmissao(address(this)), false, "Permissao nao revogada corretamente.");
    }

   // Teste para emitir um registro academico
    function testeEmitirRegistroAcademico() public {
        // Conceder permissão para a instituição de teste
        registroAcademico.concederPermissaoDeEmissao(address(this));

        uint256 matricula = 1234;

        // Emitir o registro acadêmico
        registroAcademico.emitirRegistroAcademico(address(this), matricula, "NomeAluno", "Curso", 90);

        // Recuperar o registro após a emissão
        (
            address instituicao,
            string memory nomeAluno,
            uint256 matriculaRetorno,
            string memory curso,
            uint256 nota,
            bool emitido
        ) = registroAcademico.registros(address(this), matricula);

        Assert.equal(instituicao, address(this), "A instituicao deve ser o endereco do contrato de teste");
        Assert.equal(nomeAluno, "NomeAluno", "O nome do aluno deve ser 'NomeAluno'");
        Assert.equal(matriculaRetorno, matricula, "A matricula deve ser 1234");
        Assert.equal(curso, "Curso", "O curso deve ser 'Curso'");
        Assert.equal(nota, 90, "A nota deve ser 90");
        Assert.equal(emitido, true, "O registro deve ser emitido");
    }

    
    // Teste para verificar dados do registro academico apos emissao
    function testeVerificarRegistroAposEmissao() public {
        uint256 matricula = 122;

        // Emitir o registro acadêmico
        registroAcademico.emitirRegistroAcademico(address(this),matricula, "NomeAluno", "Curso", 90);

        // Recuperar o registro após a emissão
        (
            address instituicao, 
            string memory nomeAluno, 
            uint256 matriculaRetorno, 
            string memory curso, 
            uint256 nota, 
            bool emitido
        ) = registroAcademico.registros(address(this), matricula);

        // Adicionar logs para verificar o estado do contrato durante o teste
        emit LogEstadoContrato(instituicao, nomeAluno, matriculaRetorno, curso, nota, emitido);

        Assert.equal(instituicao, address(this), "A instituicao deve ser o endereco do contrato de teste");
        Assert.equal(nomeAluno, "NomeAluno", "O nome do aluno deve ser 'NomeAluno'");
        Assert.equal(matriculaRetorno, matricula, "A matricula deve ser 123");
        Assert.equal(curso, "Curso", "O curso deve ser 'Curso'");
        Assert.equal(nota, 90, "A nota deve ser 90");
        Assert.equal(emitido, true, "O registro deve ser emitido");
    }

    // Adicionar evento de log para facilitar a verificação do estado do contrato
    event LogEstadoContrato(
    address indexed instituicao,
    string nomeAluno,
    uint256 indexed matricula,
    string curso,
    uint256 nota,
    bool emitido
);


    // Funcao de encerramento - chamada apos todos os testes
    function afterAll() public {
        // Limpeza ou acoes finais, se necessario
    }
}
