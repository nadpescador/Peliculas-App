import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculasSearch extends SearchDelegate{



  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();




  @override
  List<Widget> buildActions(BuildContext context) {
      // Acciones de nuestro Appbar
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }, 
           )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del appbar
      return IconButton(

        icon: AnimatedIcon( 
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation),
        onPressed: () => close(context, null),          
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Builder para crear los resultados que vamos a mostrar
      return buildSuggestions(context);
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
      if (query.isEmpty) {
        return Container();
      }

      return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (BuildContext context, AsyncSnapshot <List<Pelicula>>snapshot) {
          if (snapshot.hasData) {

            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  onTap: () {
                    close(context, null);
                    pelicula.uniqueID="";
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.releaseDate),
                  leading: FadeInImage(
                    placeholder: AssetImage("assets/no-image.jpg"),
                    image: NetworkImage(pelicula.getPosterImg()),
                    ),
                  
                );
              } ).toList()
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );

  }



}