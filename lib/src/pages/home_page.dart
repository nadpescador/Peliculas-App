import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/horizontal_movie.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();



  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();


    return Scaffold(
      appBar: AppBar(
        title: Text("Peliculas en cines"),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){})
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context),
            
          ],
        )),
      
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot <List> snapshot) {
       
       if (snapshot.hasData){
          return CardSwiper(
            peliculas: snapshot.data);
       } else {
         return Container(
           height: 400,
           child: Center(
             child: CircularProgressIndicator()),
         );
       }
       
       
      },
    );

//      return CardSwiper(
//        peliculas: [1,2,3,4,5]
//      );
 }

  Widget _footer( BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Populares", style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(height: 5.0),


          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              snapshot.data?.forEach((p) => print(p.title));

              if (snapshot.hasData){
                return MovieHorizontal(
                peliculas: snapshot.data,
                siguientePagina: peliculasProvider.getPopulares);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}