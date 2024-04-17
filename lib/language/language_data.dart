import 'package:get/get.dart';
import 'package:home_remedies/shared/constants/font_resources.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'app_font_family': FontResources.regular,
      'please_wait': 'Please wait...',
      'home_remedies': 'Home Remedies',
      'language': 'Language',
      'english': 'English',
      'urdu': 'Urdu',
      'empty_data_for': 'Data is empty for @name',
      'timeout_error': 'Looks like the server is taking too long to respond, please try again in some time.',
      'no_internet_error': 'Looks like you have an unstable/no network at the moment, please try again when the network stabilizes or comes back.',
      'error_message': 'Looks like the server is taking too long to respond, this can be caused by either poor connectivity or an error with our servers. Please try again in a while.',
      'no_result_found': 'Nothing found.',
      're_try': 'Re-Load',
      'press_again_to_exit': 'Press again to exit.',
      'do_not_have_data': "We don't have data.",
      'remedies': "Remedies",
      'causes': "Causes",
      'symptoms': "Symptoms",
      'causes_of': "Causes of @name",
      'symptoms_of': "Symptoms of @name",
      'detail': "Detail",
      'search_hint': "Search...",
    },
    'ur_PK': {
      'app_font_family': FontResources.urduFont,
      'please_wait': 'برائے مہربانی انتظار کریں...',
      'home_remedies': 'گھریلو علاج',
      'language': 'زبان',
      'english': 'انگریزی',
      'urdu': 'اردو',
      'empty_data_for': '@name کے لیے ڈیٹا خالی ہے۔',
      'timeout_error': 'ایسا لگتا ہے کہ سرور جواب دینے میں بہت زیادہ وقت لے رہا ہے، براہ کرم کچھ دیر بعد دوبارہ کوشش کریں۔',
      'no_internet_error': 'ایسا لگتا ہے کہ آپ کے پاس اس وقت کوئی غیر مستحکم/کوئی نیٹ ورک نہیں ہے، براہ کرم دوبارہ کوشش کریں جب نیٹ ورک مستحکم ہو جائے یا واپس آجائے۔',
      'error_message': 'ایسا لگتا ہے کہ سرور جواب دینے میں بہت زیادہ وقت لے رہا ہے، یہ یا تو خراب کنیکٹیویٹی یا ہمارے سرورز میں خرابی کی وجہ سے ہو سکتا ہے۔ براہ کرم تھوڑی دیر میں دوبارہ کوشش کریں۔',
      'no_result_found': 'کچھ نہیں ملا.',
      're_try': 'دوبارہ لوڈ کریں',
      'press_again_to_exit': 'باہر نکلنے کے لیے دوبارہ دبائیں۔',
      'do_not_have_data': 'ہمارے پاس ڈیٹا نہیں ہے۔',
      'remedies': "علاج",
      'causes': "اسباب",
      'symptoms': "علامات",
      'causes_of': "@name کی وجوہات",
      'symptoms_of': "@name کی علامات",
      'detail': "تفصیل",
      'search_hint': "تلاش کریں...",
    }
  };
}