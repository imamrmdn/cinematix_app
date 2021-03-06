part of 'widgets.dart';

class TopUpButton extends StatelessWidget {
  final Function onPressed;

  TopUpButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.only(bottom: 42),
        child: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: onPressed,
          child: Icon(MdiIcons.walletPlus),
        ),
      ),
    );
  }
}
