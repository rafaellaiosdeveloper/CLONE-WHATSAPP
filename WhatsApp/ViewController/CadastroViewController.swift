//
//  CadastroViewController.swift
//  WhatsApp
//
//  Created by Rafaella Rodrigues Santos on 14/11/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var campoNome: UITextField!
    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoSenha: UITextField!
    
    var auth: Auth!
    var firestore: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        auth = Auth.auth()
        firestore = Firestore.firestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func cadastrar(_ sender: Any) {
        if let nome = campoNome.text{
            if let email = campoEmail.text{
                if let senha = campoSenha.text{
                    
                    auth.createUser(withEmail: email, password: senha) { dadosResultado, erro in
                        if erro == nil{
                            
                            //Salvar dados do usuario no firebase
                            if let idUsuario = dadosResultado?.user.uid {
                                self.firestore.collection("usuarios")
                                    .document(idUsuario)
                                    .setData(["nome" : nome,
                                              "email" : email,
                                              "id" : idUsuario
                                             ])
                            }
                            print("Sucesso ao cadastrar usuario")
                        }else{
                            print("Erro ao cadastrar o usuario")
                        }
                    }
                }else{
                    print("Digite sua senha")
                }
            }else{
                print("Digite seu email")
            }
        }else{
            print("Digite seu nome")
        }
    }
}
