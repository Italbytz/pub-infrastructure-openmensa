import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:open_mensa_infrastructure/src/canteen.dart';
import 'package:open_mensa_infrastructure/src/day.dart';
import 'package:open_mensa_infrastructure/src/meal.dart';

class OpenMensaAPI {
  var baseUrl = "https://openmensa.org/api/v2";
  final logger = Logger();

  Future<List<Canteen>> getCanteens() async => http
      .get(Uri.parse("$baseUrl/canteens"))
      .then((http.Response r) => canteensFromJson(r.body));

  Future<List<Day>> getDays(int canteen) async => http
      .get(Uri.parse("$baseUrl/canteens/$canteen/days"))
      .then((http.Response r) => daysFromJson(r.body));

  String format(DateTime date) =>
      "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  Future<List<Meal>> getMeals(int canteen, DateTime date) async {
    var days = await getDays(canteen);
    var requestedDate = format(date);
    for (var day in days) {
      if (format(day.date) == requestedDate) {
        if (day.closed) {
          throw MensaClosedException();
        }
        return http
            .get(Uri.parse(
                "$baseUrl/canteens/$canteen/days/$requestedDate/meals"))
            .then((http.Response r) => mealsFromJson(r.body));
      }
    }
    throw NoMealsForDateException();
  }

  Future<List<Meal>> getTodaysMeals(int canteen) async {
    return getMeals(canteen, DateTime.now());
  }
}

class NoMealsForDateException implements Exception {}

class MensaClosedException implements Exception {}
