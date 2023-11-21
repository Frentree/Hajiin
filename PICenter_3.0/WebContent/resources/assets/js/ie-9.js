var placeholder = function(){
	$('input').each(function(){
		var _this = $(this),
			_thisP = _this.parent(),
			placeholderAttr = _this.attr('placeholder');
		_this.parent().append('<div class="placeholder">' + placeholderAttr + '</div>');

		var _thisPlaceholder = _thisP.find('.placeholder')

		var placeShowHide = function(){
			if( _this.val().length > 0 ){
				_thisPlaceholder.hide();
			}else{
				_thisPlaceholder.show();
			}
		}
		
		placeShowHide()

		_this.keyup(function(){
			placeShowHide()
		});

		$('.placeholder').click(function(){
			$(this).parent().find('input').focus()
		})

		_this.blur(function(){
			placeShowHide()
		});
		
	})
}
$(document).ready(function(){
	placeholder()
});
