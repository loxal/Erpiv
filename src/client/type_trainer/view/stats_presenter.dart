class Stats {
    DivElement statsPanel;
    Element host;
    int totalChars;
    int mistakeCount;

    void show() {
        final double mistakeRate = mistakeCount / totalChars;

        final XMLHttpRequest retrieveView = new XMLHttpRequest();
        retrieveView.open('GET', '../type_trainer/view/stats.html');
        retrieveView.on.load.add((final Event e) {
            statsPanel = new Element.html(retrieveView.responseText);
            statsPanel.query('#mistakeCount').text = mistakeCount.toStringAsFixed(0);
            statsPanel.query('#totalChars').innerHTML = totalChars.toStringAsFixed(0);
            statsPanel.query('#errorRate').innerHTML = '${(mistakeRate * 100).round()}';

            host.elements.add(statsPanel);
        });
        retrieveView.send();
    }

    void remove() {
        statsPanel.remove();
    }

    Stats(this.host, this.totalChars, this.mistakeCount) {
        show();
    }
}