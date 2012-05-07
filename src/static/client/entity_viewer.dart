class EntityViewer {
  Map<String, Object> _scopes;
  Element _fragment;

  int number;

  EntityViewer(this.number) : _scopes = new Map<String, Object>() {
    document.head.elements.add(new Element.html("""<style>
         .viewBox {
           padding: .1em;
           margin: 0 .1em 0 .1em;
           float: right;
           border-radius: .2em;
           border: 1px solid hsl(33, 55%, 55%);
         }
    </style>"""));

    _fragment = new DocumentFragment();
    var e0 = new Element.html('''
       	<fieldset>
       	    <legend id="my">Symbol Display</legend>
       	    <span class="viewBox" style="font-size: 1em;">&#x2724;</span>
       	    <span class="viewBox" style="font-size: 2em;">&#x2658;</span>
       	    <span class="viewBox" style="font-size: 3em;">&#x2620;</span>
       	    <span class="viewBox" style="font-size: 6em;">&#x2624;</span>
       	    <label for="symbolId">Symbol Id:</label>
       	    <input type="text" id="symbolId" value="x274a">&nbsp;</input>

       	    <p>E.g. "10046" in <em>decimal</em> notation or "<strong>x</strong>27bd" in <em>hexadecimal</em> notation</p>
       	    <button id="symbol-display" class="icon-list">Display Symbol</button>
       	</fieldset>
    ''');
    _fragment.elements.add(e0);
  }

  Element get root() => _fragment;
}
