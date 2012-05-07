class EntityContainer {
  Map<String, Object> _scopes;
  Element _fragment;

  List entities;

  var tbodyl;

  EntityContainer(this.entities) : _scopes = new Map<String, Object>() {
    _fragment = new DocumentFragment();
    var e0 = new Element.html("""
       	<table>
       		<caption>Container</caption>
       		<thead>
       			<tr>
       				<td>#</td>
       				<td>Symbol</td>
       				<td>Decimal Notation</td>
       			</tr>
       		</thead>
       		<tbody var="tbodyl">
       				<tr>
       					<td>${entities}</td>
       					<td></td>
       					<td></td>
       				</tr>
       		</tbody>
       		<tfoot></tfoot>
       	</table>
    """);
    _fragment.elements.add(e0);
  }

  Element get root() => _fragment;
}
