// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Compartilhamento {
// Estrutura de dados para representar uma solicitação de compartilhamento
    struct Solicitacao {
        address aluno;
        address destinatario;
        uint256 matricula;
        string informacoesCompartilhadas;
        bool aprovada;
        }

    // Array para armazenar todas as solicitações de compartilhamento
    Solicitacao[] public solicitacoesDeCompartilhamento;

    // Mapeamento para verificar se uma solicitação já foi aprovada
    mapping(uint256 => bool) public solicitacaoAprovada;

    // Evento para registrar a solicitação de compartilhamento
    event SolicitacaoDeCompartilhamento(uint256 indexed matricula, address indexed aluno, address indexed destinatario);

    // Evento para registrar a aprovação da solicitação de compartilhamento
    event CompartilhamentoAprovado(uint256 indexed matricula, address indexed aluno, address indexed destinatario);

    // Função interna para verificar se o remetente é o aluno da matrícula especificada
    function validarAluno(uint256 matricula) internal view {
        require(msg.sender == solicitacoesDeCompartilhamento[matricula].aluno, "Apenas o aluno pode realizar esta acao.");
    }

    // Função para criar uma solicitação de compartilhamento
    function solicitarCompartilhamento(uint256 matricula, string memory informacoesCompartilhadas) public {
    // Verifica se a matrícula ainda não possui uma solicitação em andamento
        require(!solicitacaoAprovada[matricula], "Ja existe uma solicitacao aprovada para esta matricula.");

        // Cria a solicitação de compartilhamento
        Solicitacao memory novaSolicitacao = Solicitacao({
            aluno: msg.sender,
            destinatario: address(0), // O destinatário será definido posteriormente na aprovação
            matricula: matricula,
            informacoesCompartilhadas: informacoesCompartilhadas,
            aprovada: false
        });

        // Adiciona a solicitação ao array
        solicitacoesDeCompartilhamento.push(novaSolicitacao);

        // Emite o evento
        emit SolicitacaoDeCompartilhamento(matricula, msg.sender, address(0));
    }

    //Função para obter o numero de solicitacoes
    function obterNumeroDeSolicitacoes() public view returns (uint256) {
    return solicitacoesDeCompartilhamento.length;
    }

    // Função para aprovar uma solicitação de compartilhamento
    function aprovarCompartilhamento(uint256 index) public {
        // Valida se o remetente é o aluno da matrícula associada à solicitação
        validarAluno(index);

        // Verifica se a solicitação ainda não foi aprovada
        require(!solicitacoesDeCompartilhamento[index].aprovada, "Esta solicitacao ja foi aprovada.");

        // Define o destinatário como o remetente da transação
        solicitacoesDeCompartilhamento[index].destinatario = msg.sender;

        // Define a solicitação como aprovada
        solicitacoesDeCompartilhamento[index].aprovada = true;

        // Atualiza o mapeamento indicando que a solicitação foi aprovada
        solicitacaoAprovada[index] = true;

        // Emite o evento de aprovação
        emit CompartilhamentoAprovado(index, solicitacoesDeCompartilhamento[index].aluno, msg.sender);
    }
}