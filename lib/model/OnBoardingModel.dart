class OnBoardingModel {
  String image;
  String title;
  String description;

  OnBoardingModel({this.image, this.title, this.description});
}

List<OnBoardingModel> pages = [
  OnBoardingModel(
      description:
          "It's not about the destination, it's about the journey.We prioritise your safety more than anything",
      title: 'Ensure Your Safety With Us',
      image: 'assets/images/screen1.png'),
  OnBoardingModel(
      description:
          'We recommend you the safest route to reach your destination by analyzing incidents and crime reports',
      title: 'Safety Over Speed',
      image: 'assets/images/screen2.png'),
  OnBoardingModel(
      description:
          'Share live location with your loved ones and get immediate access to the safety toolkit.You are not alone.!!',
      title: 'Stay Connected',
      image: 'assets/images/screen3.png')
];
