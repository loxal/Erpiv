#import('dart:html');

class SVGSamples {
  void run() {
    drawlines();
  }

  void drawlines() {
    final int maxY = 250;
    final int maxX = 500;
    final int step = 10;

    var svgGroup = new SVGElement.tag("g");
    svgGroup.attributes["transform"] = "translate(0,$maxY) scale(1,-1)";

    for(int i=0; i<(maxX/step); i++) {
      var xAxis = new SVGElement.tag("line");
      xAxis.attributes = {
        "x1": i*step,
        "y1": 0,
        "x2": i*step,
        "y2": (i%10 == 0 ? 16 : 8),
        "stroke": (i%10 == 0 ? "#8cf" : "blue"),
        "stroke-width": "1"
      };
      svgGroup.nodes.add(xAxis);
    }
    for(int i=0; i<(maxY/step); i++) {
      var yAxis = new SVGElement.tag("line");
      yAxis.attributes = {
        "x1": 0,
        "y1": i*step,
        "x2": (i%10 == 0 ? 16 : 8),
        "y2": i*step,
        "stroke": (i%10 == 0 ? "#8cf" : "blue"),
        "stroke-width": "1"
      };
      svgGroup.nodes.add(yAxis);
    }

    var svg = new SVGElement.tag("svg");
    svg.nodes.add(svgGroup);
    svg.attributes = {
       "height": maxY,
       "width": maxX,
       "version": "1.1"
    };
    document.query("#container").nodes.add(svg);
  }
}

void main() {
  new SVGSamples().run();
}