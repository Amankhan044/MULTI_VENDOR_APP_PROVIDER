import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final List<String> _bannerImages = [];

  getBanner() {
    _firebaseFirestore
        .collection('banners')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((docs) {
        setState(() {
          _bannerImages.add(docs['image']);
        });
      });
    });
  }

  @override
  void initState() {
    getBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.yellow.shade900,
              borderRadius: BorderRadius.circular(10)),
          child: PageView.builder(
              itemCount: _bannerImages.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: _bannerImages[index],
                    placeholder: (context, url) => Shimmer(
                      duration: Duration(seconds: 3), 
                      interval: Duration(
                          seconds: 5),
                      color: Colors.white, 
                      colorOpacity: 0, 
                      enabled: true,
                      direction: ShimmerDirection.fromLTRB(), 
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              })),
    );
  }
}
