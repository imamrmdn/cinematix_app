part of 'services.dart';

class MovieService {
  static Future<List<Movie>> getMovie(int page, {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page';

    client ??= http.Client();

    var response = await client.get(url);
    //
    if (response.statusCode != 200) {
      return [];
    }
    //
    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  //
  static Future<MovieDetail> getDetails(Movie movie,
      {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/${movie.id}?api_key=$apiKey&language=en-US';

    client ??= http.Client();
    var response = await client.get(url);
    var data = json.decode(response.body);

    //
    List genres = (data as Map<String, dynamic>)['genres'];
    String language;

    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = 'Japan';
        break;
      case 'id':
        language = 'Indonesia';
        break;
      case 'en':
        language = 'English';
        break;
      case 'ko':
        language = 'Korean';
        break;
      case 'fi':
        language = 'Finlandia';
        break;
      case 'as':
        language = 'Asian';
        break;
      default:
        language = 'American';
        break;
    }

    return MovieDetail(movie,
        language: language,
        genres: genres
            .map((e) => (e as Map<String, dynamic>)['name'].toString())
            .toList());
  }

  //
  static Future<List<Credit>> getCredits(int movieID,
      {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieID/credits?api_key=a97404961ffaee398ecf0400ce2dbba6';

    client ??= http.Client();
    var response = await client.get(url);
    var data = json.decode(response.body);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
              name: (e as Map<String, dynamic>)['name'],
              profilePath: (e as Map<String, dynamic>)['profile_path'],
            ))
        .take(8)
        .toList();
  }
}
