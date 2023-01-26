import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: CachedNetworkImage(
        width: MediaQuery.of(context).size.width,
        height: 200,
        imageUrl:
            "https://img.freepik.com/free-vector/hand-drawn-local-market-sale-banner_23-2149487585.jpg?w=2000",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const Icon(Icons.image),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
