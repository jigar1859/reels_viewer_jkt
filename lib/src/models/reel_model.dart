import 'package:reels_viewer/reels_viewer.dart';

class ReelModel {
  final String? id;
  final String url;
  final bool isLiked;
  final int likeCount;
  final String userName;
  final String? profileUrl;
  final String? reelDescription;
  final String? musicName;
  final List<ReelCommentModel>? commentList;
  ReelModel(this.url, this.userName,
      {this.id,
      this.isLiked = false,
      this.likeCount = 0,
      this.profileUrl,
      this.reelDescription,
      this.musicName,
      this.commentList});

  ReelModel.fromJson(
      Map<String, dynamic> json, this.likeCount, this.commentList)
      : id = json['id'],
        url = json['url'],
        isLiked = json['isLiked'],
        userName = json['userName'],
        profileUrl = json['profileUrl'],
        reelDescription = json['reelDescription'],
        musicName = json['musicName'];

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
