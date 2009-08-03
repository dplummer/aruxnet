function AutoCardMagicCardsInfo(cardname, set) {
	if (set == undefined) set = '';
	uri = cardname.replace(/\//g,'[') + '|' + set;
	params = 'width=950, height=500, scrollbars=1, resizable=1, menubar=0, status=0';
	window.open('http://www.magiccards.info/autocard.php?card=' + uri, 'autocard', params);
}
var AutoCard = AutoCardMagicCardsInfo;
function s(n){var i=document.getElementById('card');i.src="/images/cards/"+n+".jpg";}
