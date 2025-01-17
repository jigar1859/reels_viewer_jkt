import 'package:reels_viewer/reels_viewer.dart';
import 'package:hive/hive.dart';

part 'reel_model.g.dart';

@HiveType(typeId: 01)
class ReelModel extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String url;

  @HiveField(2)
  final bool isLiked;

  @HiveField(3)
  final int likeCount;

  @HiveField(4)
  final String userName;

  @HiveField(5)
  final String? profileUrl;

  @HiveField(6)
  final String? reelDescription;

  @HiveField(7)
  final String? musicName;

  @HiveField(8)
  final List<ReelCommentModel>? commentList;

  ReelModel(this.url, this.userName,
      {this.id,
      this.profileUrl,
      this.reelDescription,
      this.musicName,
      this.commentList,
      //Hard Coded
      this.isLiked = false,
      this.likeCount = 0});

  ReelModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        userName = json['userName'],
        profileUrl = json['profileUrl'],
        reelDescription = json['reelDescription'],
        musicName = json['musicName'],
        //Hard Coded
        isLiked = true,
        likeCount = 5000,
        commentList = [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'isLiked': isLiked,
        'userName': userName,
        'profileUrl': profileUrl,
        'reelDescription': reelDescription,
        'musicName': musicName
      };
}
