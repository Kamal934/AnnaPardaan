import 'package:annapardaan/utils/constants/images.dart';
import '../../models/onboarding_info.dart';
import '../../utils/constants/text_strings.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: TText.onBoardingTitle1,
      description: TText.onBoardingSubTitle1,
      image:TImages.onBoardingImage1 ,
    ),

    // Slide 2
    OnboardingInfo(
      title:TText.onBoardingTitle2,
      description:
          TText.onBoardingSubTitle2,
      image: TImages.onBoardingImage2,
    ),

    // Slide 3
    OnboardingInfo(
      title: TText.onBoardingTitle3,
      description:
          TText.onBoardingSubTitle3,
      image: TImages.onBoardingImage3,
    ),
  ];
}
