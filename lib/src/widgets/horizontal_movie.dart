import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';


class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
          initialPage: 1,
          viewportFraction: 0.3,);

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() { 
        if (_pageController.position.pixels >= _pageController.position.maxScrollExtent-200){
          print ('Cargar mas peliculas');
          siguientePagina();

        }
      });
    
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, index) {
          return _crearTarjeta(context, peliculas[index]);
        },
        //children: _tarjetas(context),
      ),
    );
    
  }

  Widget _crearTarjeta(BuildContext context, Pelicula pelicula){
    final peliculaTarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
              children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage("assets/no-image.jpg"),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 160,),
              ),
              Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,),
            ],
          
        ),
      );

      return GestureDetector(
        child: peliculaTarjeta,
        onTap: () {

          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
          print ('ID de la pelicula ${pelicula.title}');
        },
      );
  }

  List<Widget> _tarjetas(context) {
    
    return peliculas.map((pelicula) {


      return Container(
        margin: EdgeInsets.only(right: 15.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
              children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage("assets/no-image.jpg"),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 160,),
              ),
              Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,),
              
               
               
            ],
          
        ),
      );
    }).toList();
  }
}