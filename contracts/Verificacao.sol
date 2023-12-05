// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Verificacao {
    struct RegistroVerificavel {
        address instituicao;
        string nomeAluno;
        uint256 matricula;
        string curso;
        uint256 nota;
        bool emitido;
    }

    mapping(uint256 => RegistroVerificavel) public registrosVerificaveis;

    event VerificacaoConfirmada(uint256 indexed matricula, string indexed nomeAluno, address indexed instituicao);

    function verificarRegistro(uint256 matricula) public returns (bool) {
        RegistroVerificavel memory registro = registrosVerificaveis[matricula];

        if (registro.emitido) {
            emit VerificacaoConfirmada(matricula, registro.nomeAluno, registro.instituicao);
            return true;
        }

        return false;
    }

    // Função para adicionar um registro (apenas para fins de teste)
    function adicionarRegistro(
        address _instituicao,
        string memory _nomeAluno,
        uint256 _matricula,
        string memory _curso,
        uint256 _nota,
        bool _emitido
    ) public {
        registrosVerificaveis[_matricula] = RegistroVerificavel({
            instituicao: _instituicao,
            nomeAluno: _nomeAluno,
            matricula: _matricula,
            curso: _curso,
            nota: _nota,
            emitido: _emitido
        });
    }
}
