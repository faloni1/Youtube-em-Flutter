import 'package:flutter/material.dart';
import 'package:youtube/api.dart';
import 'package:youtube/model/video.dart';
import 'package:youtube/telas/tela_video.dart';

class Inicio extends StatefulWidget {

  String pesquisa;

  Inicio(this.pesquisa);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideos(String pesquisa) {
    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
        future: _listarVideos(widget.pesquisa),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator()
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if(snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      List<Video>? videos = snapshot.data;
                      Video video = videos![index];

                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                    builder: (context) => TelaVideo(videoId: video.id),
                              )
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(video.imagem)
                                  )
                              ),
                            ),
                            ListTile(
                              title: Text(video.titulo),
                              subtitle: Text(video.canal),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.white,
                    ),
                    itemCount: snapshot.data!.length
                );
              } else {
                return Center(
                  child: Text("Nenhum dado a ser exibido.")
                );
              }
          }
        }
    );
  }
}
