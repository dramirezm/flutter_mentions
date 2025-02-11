part of flutter_mentions;

class OptionList extends StatelessWidget {
  OptionList({
    this.data,
    this.onTap,
    this.suggestionListHeight,
    this.suggestionListWidth,
    this.suggestionBuilder,
    this.suggestionListDecoration,
    this.onClose,
    this.scrollController
  });

  final Widget Function(Map<String, dynamic>) suggestionBuilder;
  final ScrollController scrollController;

  final List<Map<String, dynamic>> data;

  final Function(Map<String, dynamic>) onTap;
  final Function() onClose;

  final double suggestionListHeight;
  final double suggestionListWidth;

  final BoxDecoration suggestionListDecoration;

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? WillPopScope(
      onWillPop: onClose,
          child: Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onTap: onClose,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration:
                suggestionListDecoration ?? BoxDecoration(color: Colors.white),
                constraints: BoxConstraints(
                  maxHeight: suggestionListHeight,
                  minHeight: 0,
                  minWidth: 0,
                  maxWidth: suggestionListWidth,
                ),
                child: Scrollbar(
                  controller: scrollController,
                  isAlwaysShown: data.length  <= 1 ?  false: true,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          onTap(data[index]);
                        },
                        child: suggestionBuilder != null
                            ? suggestionBuilder(data[index])
                            : Container(
                          color: Colors.blue,
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            data[index]['display'],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

          ],),
        )
        : Container();
  }
}
