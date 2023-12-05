// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RegistroAcademico {
    // Estrutura de dados para representar um registro acadêmico
    struct Registro {
        address instituicao;
        string nomeAluno;
        uint256 matricula;
        string curso;
        uint256 nota;
        bool emitido;
    }

    
    // Mapeamento para armazenar registros acadêmicos por matrícula e instituição
    mapping(address => mapping(uint256 => Registro)) public registros;

    // Mapeamento para armazenar permissões de emissão por instituição
    mapping(address => bool) public permissoesDeEmissao;

    // Evento para registrar a emissão de um registro acadêmico
    event RegistroEmitido(uint256 indexed matricula, string indexed nomeAluno, address indexed instituicao);

    // Modificador para verificar permissões de emissão
    modifier temPermissaoDeEmissao() {
        require(permissoesDeEmissao[msg.sender], "Voce nao tem permissao para emitir registros academicos.");
        _;
    }

    // Função para conceder permissão de emissão a uma instituição
    function concederPermissaoDeEmissao(address instituicao) public {
        require(!permissoesDeEmissao[instituicao], "Permissao ja concedida para esta instituicao.");
        permissoesDeEmissao[instituicao] = true;
    }

    // Função para revogar permissão de emissão de uma instituição
    function revogarPermissaoDeEmissao(address instituicao) public {
        require(permissoesDeEmissao[instituicao], "Esta instituicao nao possui permissao de emissao.");
        permissoesDeEmissao[instituicao] = false;
    }

    function emitirRegistroAcademico(
    address instituicao,
    uint256 matricula,
    string memory nomeAluno,
    string memory curso,
    uint256 nota
) public temPermissaoDeEmissao {
    // Verifica se o registro ainda não foi emitido
    require(!registros[instituicao][matricula].emitido, "Este registro ja foi emitido.");

    // Cria o registro acadêmico
    registros[instituicao][matricula] = Registro({
        instituicao: instituicao,
        nomeAluno: nomeAluno,
        matricula: matricula,
        curso: curso,
        nota: nota,
        emitido: true
    });

    // Emite o evento
    emit RegistroEmitido(matricula, nomeAluno, instituicao);
}

}
