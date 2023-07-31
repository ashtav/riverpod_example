part of widget;

class CustomCheckbox extends StatelessWidget {
  final bool value;
  const CustomCheckbox({super.key, this.value = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 27,
      height: 27,
      decoration: BoxDecoration(border: Br.all(), borderRadius: Br.radius(5), color: Colors.white),
      child: value ? const Center(child: Icon(Ti.check)) : const None(),
    );
  }
}
