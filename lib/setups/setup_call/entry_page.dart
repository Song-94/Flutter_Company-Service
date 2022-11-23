import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import '../../path/image.dart';
import 'cam_page.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: svg_provider.Svg(SCREEN_CALL_ENTRYPAGE)),
      ),
      child:

      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(Icons.call),
          _EntryButton(),
          SizedBox(height: 50,),
        ],
      )

    );
  }
}
class _EntryButton extends StatelessWidget {
  const _EntryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CamScreen(),
              ),
            );
          },
          child: const Text('입장하기'),
        ),
      ],
    );
  }
}
