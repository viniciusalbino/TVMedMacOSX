//
//  User.swift
//  TVMed
//
//  Created by Vinicius Albino on 31/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    var email = ""
    var nome = ""
    var senha = ""
    var especialidade = ""
    var cpf = ""
    var cnpj = ""
    var endereco = ""
    var enderecoNumero = ""
    var enderecoComplemento = ""
    var bairro = ""
    var cidade = ""
    var estado = ""
    var pais = ""
    var gmt_codigo = 0
    var cep = ""
    var enderecoNf = ""
    var enderecoNumeroNf = ""
    var bairroNf = ""
    var cidadeNf = ""
    var estadoNf = ""
    var cepNf = ""
    var foneDdd = ""
    var foneNumero = ""
    var foneDdd2 = ""
    var foneNumero2 = ""
    var pedidos = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        email <- map["email"]
        nome <- map["nome"]
        senha <- map["senha"]
        especialidade <- map["especialidade"]
        cpf <- map["cpf"]
        cnpj <- map["cnpj"]
        endereco <- map["endereco"]
        enderecoNumero <- map["enderecoNumero"]
        enderecoComplemento <- map["enderecoComplemento"]
        bairro <- map["bairro"]
        cidade <- map["cidade"]
        estado <- map["estado"]
        pais <- map["pais"]
        gmt_codigo <- map["gmt_codigo"]
        cep <- map["cep"]
        enderecoNf <- map["enderecoNf"]
        enderecoNumeroNf <- map["enderecoNumeroNf"]
        bairroNf <- map["bairroNf"]
        cidadeNf <- map["cidadeNf"]
        estadoNf <- map["estadoNf"]
        cepNf <- map["cepNf"]
        foneDdd <- map["foneDdd"]
        foneNumero <- map["foneNumero"]
        foneDdd2 <- map["foneDdd2"]
        foneNumero2 <- map["foneNumero2"]
        pedidos <- map["pedidos"]
    }
    
    func isEligibleToBuy() -> Bool {
        guard !nome.isEmpty, !endereco.isEmpty, !enderecoNumero.isEmpty, !cidade.isEmpty, !estado.isEmpty, !cep.isEmpty, !pais.isEmpty,
            !email.isEmpty, !foneDdd.isEmpty, !foneNumero.isEmpty, checkValidDocument() else {
                return false
        }
        return true
    }
    
    func checkValidDocument() -> Bool {
        guard !cnpj.isEmpty || !cpf.isEmpty else {
            return false
        }
        return true
    }
    
    func getDocumentNumber() -> String {
        return cpf.length() > 0 ? cpf : cnpj
    }
}
