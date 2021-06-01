class pantallas {

  PImage entorno;
  PImage aux;

  pantallas(PImage ent_init, PImage aux_init) {

    entorno = ent_init;
    aux = aux_init;
    
   
  }
  
  void pintarPantalla(){
  
  image(entorno, 0,0);
  image(aux,0,0);
    
  }
  
  
}
