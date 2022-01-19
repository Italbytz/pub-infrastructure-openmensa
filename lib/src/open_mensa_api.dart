import 'package:http/http.dart' as http;
import 'package:open_mensa_infrastructure/src/canteen.dart';
import 'package:open_mensa_infrastructure/src/day.dart';
import 'package:open_mensa_infrastructure/src/meal.dart';

class OpenMensaAPI {
  var baseUrl = "https://openmensa.org/api/v2";

  Future<List<Canteen>> getCanteens() async => http
      .get(Uri.parse("$baseUrl/canteens"))
      .then((http.Response r) => canteensFromJson(r.body));

  Future<List<Day>> getDays(int canteen) async => http
      .get(Uri.parse("$baseUrl/canteens/$canteen/days"))
      .then((http.Response r) => daysFromJson(r.body));

  Future<List<Meal>> getMeals(int canteen, DateTime date) async {
    var days = await getDays(canteen);
    var requestedDate =
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    for (var day in days) {
      if (day.date == requestedDate) {
        if (day.closed) {
          throw UnsupportedError("message");
        }
        return http
            .get(Uri.parse(
                "$baseUrl/canteens/$canteen/days/$requestedDate/meals"))
            .then((http.Response r) => mealsFromJson(r.body));
      }
    }
    throw UnsupportedError("message");
  }
}
