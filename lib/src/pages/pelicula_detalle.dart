import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20,),
                _posterTitulo(pelicula, context),
                _descripcion(pelicula)
              ]
            ))

        ],
      ),
    );
    
  }


  Widget _crearAppBar(Pelicula pelicula ) {

    return SliverAppBar(
      
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      pinned: true,
      
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(pelicula.title),
        background: FadeInImage(
          placeholder: AssetImage("assets/loading.gif"),
          image: NetworkImage(pelicula.getBackgropPath()),
          fit: BoxFit.cover,),
      ),
      
    );
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context) {
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 150,),
          ),
          SizedBox(width: 20,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis,),
                Text(pelicula.releaseDate, style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString())
                  ],
                )
              ],
            ))
        ],
      ),
    );
  }

  _descripcion(Pelicula pelicula) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Text(
          pelicula.overview,
          textAlign: TextAlign.justify,),
      );
  }
}