void main() {
  Carro c1 = Carro("Fusca");
 
  c1.acelerar(100);
}

class Carro extends Automovel {
  String nome;
  int velocidade; 
  
  Carro(this.nome);
  
  void acelerar(int velocidade) {
    this.velocidade = velocidade;
    print("Acelerando $nome  com $velocidade km/h");
  }
  
  String toString() {
    return nome;
  }
}

abstract class Automovel {
  void acelerar(int velocidade);
}
