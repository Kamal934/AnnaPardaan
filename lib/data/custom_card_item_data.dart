// data/custom_card_item_data.dart

import '../models/custom_card_item_model.dart';

List<TopLeaderBoardCardItemModel> getCustomCardItems() {
  return [
    const TopLeaderBoardCardItemModel(
      name: 'The Mar Vista',
      imagePath: 'https://images.pexels.com/photos/819530/pexels-photo-819530.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      points: 2650,
    ),
    const TopLeaderBoardCardItemModel(
      name: 'Holiday Motel',
      imagePath: 'https://images.pexels.com/photos/1192609/pexels-photo-1192609.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      points: 2750,
    ),
    const TopLeaderBoardCardItemModel(
      name: 'Muji Hotel',
      imagePath: 'https://images.pexels.com/photos/2896428/pexels-photo-2896428.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      points: 2500,
    ),
    // Add more items as needed
  ];
}
