import 'package:flutter/material.dart';
import 'package:rate_dogs/models/dog_model.dart';

class DogCard extends StatefulWidget {
  final Dog dog; 

  DogCard(this.dog);

  @override 
  _DogCardState createState() => _DogCardState(dog);
}

class _DogCardState extends State<DogCard> {
  Dog dog; 
  String renderUrl; 

  _DogCardState(this.dog);

  void initState() {
    super.initState();
    renderDogPic();
  }

  void renderDogPic() async {
    // this makes the service call
    await dog.getImageUrl();
    // setState tells Flutter to rerender anything that's been changed.
    // setState cannot be async, so we use a variable that can be overwritten
    if (mounted) { // Avoid calling `setState` if the widget is no longer in the widget tree.
      setState(() {
        renderUrl = dog.imageUrl;
      });
    }
  }

  Widget get dogImage {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle, 
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(renderUrl ?? ''),
        ),
      ),
    );
  }

  Widget get dogCard {
    // A new container
    // The height and width are arbitrary numbers for styling.
    return Container(
      width: 290.0,
      height: 115.0,
      child: Card(
        color: Colors.black87,
        // Wrap children in a Padding widget in order to give padding.
        child: Padding(
          // The class that controls padding is called 'EdgeInsets'
          // The EdgeInsets.only constructor is used to set
          // padding explicitly to each side of the child.
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 64.0,
          ),
          // Column is another layout widget -- like stack -- that
          // takes a list of widgets as children, and lays the
          // widgets out from top to bottom.
          child: Column(
            // These alignment properties function exactly like
            // CSS flexbox properties.
            // The main axis of a column is the vertical axis,
            // `MainAxisAlignment.spaceAround` is equivalent of
            // CSS's 'justify-content: space-around' in a vertically
            // laid out flexbox.
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(widget.dog.name,
                  // Themes are set in the MaterialApp widget at the root of your app.
                  // They have default values -- which we're using because we didn't set our own.
                  // They're great for having consistent, app-wide styling that's easily changed.
                  style: Theme.of(context).textTheme.headline),
              Text(widget.dog.location,
                  style: Theme.of(context).textTheme.subhead),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                  ),
                  Text(': ${widget.dog.rating} / 10')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 115.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 50.0,
              child: dogCard,
            ),
            Positioned(top: 7.5, child: dogImage),
          ],
        ),
      ),
    );
  }
}