void main() {
  Carro c1 = Carro("Fusca")..ano=1975;
  Carro c2 = Carro("Brasilia")..ano=1980;
  Carro c3 = Carro("Chevete")..ano=1985;
  
  final carros = [c1, c2, c3];
//   carros.add(c1);
//   carros.add(c2);
//   carros.add(c3);
  
  print("Lista: $carros, length: ${carros.length}");
  
  for(Carro c in carros) {
    print(" >> ${c.nome} ano : ${c.ano}");
  }
}

class Carro {
  String nome;
  int ano;
  
  Carro(this.nome);
  
  String toString() {
    return nome + '|' +  ano.toString();
  }
}
