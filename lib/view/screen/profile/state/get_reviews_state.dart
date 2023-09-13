import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/view/screen/profile/model/get_reviews_model.dart';

class ReviewSuccessState extends SuccessState {
  ReviewModel? reviewModel;
  ReviewSuccessState(this.reviewModel);
}
