
var isNull = function(value) { 
	var ret = null;
	if( value == "" || value == null || value == undefined || value == "undefined" || 
			( value != null && typeof value == "object" && !Object.keys(value).length ) ) { 
		ret = true;
	}
	else {
		ret = false;
	}

	//console.log("isEmpty == " + ret);
	return ret;
}

function getToday()
{
	var date = new Date();

	return (date.getFullYear()).toString() + (("00" + (date.getMonth() + 1).toString()).slice(-2)) + ("00" + (date.getDate()).toString()).slice(-2);
}

function getDateTime(date, period, interval)
{
	if (isNull(date)) date = new Date();
	
	if (!isNull(period)) {
		if (period == "mi") date = new Date(date.getTime() + interval*60000);
	}
	
	return (date.getFullYear()).toString() + (("00" + (date.getMonth() + 1).toString()).slice(-2)) + ("00" + (date.getDate()).toString()).slice(-2)
			+ ("00" + (date.getHours()).toString()).slice(-2)
			+ ("00" + (date.getMinutes()).toString()).slice(-2)
			+ ("00" + (date.getSeconds()).toString()).slice(-2);
}

var add_minutes =  function (dt, minutes) {
    return new Date(dt.getTime() + minutes*60000);
}

function convertUnixTime2Date(t) {     
    var a = new Date(t * 1000);
    var today = new Date();
    var yesterday = new Date(Date.now() - 86400000);
    var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    var year = a.getFullYear();
    var month = a.getMonth() + 1;
    var date = a.getDate();
    var hour = a.getHours();
    var min = a.getMinutes();
    var sec = a.getSeconds();
    if (a.setHours(0,0,0,0) == today.setHours(0,0,0,0))
        return 'today, ' + hour + ':' + min;
    else if (a.setHours(0,0,0,0) == yesterday.setHours(0,0,0,0))
        return 'yesterday, ' + hour + ':' + min;
    else if (year == today.getFullYear())
        return year + "-" + month + "-" + date + " " + hour + ":" + min;
    else
    	return year + "-" + month + "-" + date + " " + hour + ":" + min;
}

function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
//숫자 타입에서 쓸 수 있도록 format() 함수 추가
Number.prototype.format = function(){
    if(this==0) return 0;
 
    var reg = /(^[+-]?\d+)(\d{3})/;
    var n = (this + '');
 
    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
 
    return n;
};
 
// 문자열 타입에서 쓸 수 있도록 format() 함수 추가
String.prototype.format = function(){
    var num = parseFloat(this);
    if( isNaN(num) ) return "0";
 
    return num.format();
};
