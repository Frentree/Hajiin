$(document).ready(function() {
	/* remove select css */
	$('select').css({'padding':'7px 10px 7px 13px','height':'auto','background':'none'});
	$('input.input[readonly="readonly"]').css({'border': '1px solid #e0e0e0', 'color': '#b6b6b6', 'background': '#f7f7f7', 'font-weight':'normal'});

	$('div.btn_toggle span.on').css({'z-index':'2','border':'1px solid #384463','background':'#ffffff','color':'#384463','font-weight':'bold','padding':'7px 10px'});
	

});

// NOTE: This script is meant for IE<=8 ONLY. Make sure to include it using conditional comments if you don't want errors in modern browsers.
// Requires jQuery 1.x (compatible with IE7-8) version >= 1.7 (tested up to 1.10.2)
// Avoid loading this script asynchronously, unrecognized selectors in inline style elements are lost after DOM ready
(function($) {

	var CHECKED_CLASS = 'poly-checked',
		JUST_CHANGED_PARENT_CLASS = 'poly-just-changed',
		PATCHED_DATA_PROP = 'isPolyChecked',
		inputsLiveNodeList = document.getElementsByTagName('input');

	function patchStylesheet(elem, text) {
		// A global replace here is a bit hackish, but works for the great majority of use cases.
		// Issue: may have unintended effects on CSS strings (URLs, content property value) containing the ":checked" substring.
		// Workaround: Use an escape sequence: "\00003Achecked" and "\3A checked" will both print ":checked"
		//(U+0020 space characters immediately following a hexadecimal escape sequence are automatically consumed by the escape sequence)
		elem.styleSheet.cssText = text.replace(/:checked/g, '.' + CHECKED_CLASS);
	}

	$('style').each(function() {
		// Retrieving the style element's innerHTML only works before DOM ready,
		// after DOM ready the rules with invalid selectors are simply removed from the style's innerHTML. (dafaq microsoft??)
		patchStylesheet(this, this.innerHTML);
	});

	$('link[rel=stylesheet]').each(function() {
		var elem = this;
		// There's apparently no other way to retrieve an external stylesheet's text content other than XHR.
		// Issue: can't polyfill stylesheets from other domains due to same-origin policy.
		// Workaround: host all stylesheets that need polyfilling in the same domain from where they're being <link>ed to.
		$.get(this.href, function(rawCSSText) {
			patchStylesheet(elem, rawCSSText);
		});
	});

	function patchInput(elem) {
		// Every input has unchecked styling until patched, so we only need to refresh the checked ones' styling.
		if (elem.checked) refreshStyling(elem);

		// propertychange fires due to both user action and JS code, which is ideal for our use case.
		// Too bad it doesn't bubble though, hence we need to patch each input manually. See patchNonPatchedInputs below.
		$(elem).on('propertychange._polychecked', function(e) {
			if (e.originalEvent.propertyName === 'checked') {
				refreshStyling(this);
			}
		}).data(PATCHED_DATA_PROP, 1);
	}

	function refreshStyling(elem) {
		$(elem).toggleClass(CHECKED_CLASS, elem.checked)
			//and now we force IE to execute selectors matching again so that sibling selectors work
			.parent().addClass(JUST_CHANGED_PARENT_CLASS).removeClass(JUST_CHANGED_PARENT_CLASS);
	}

	function patchNonPatchedInputs() {
		// As this will be used for polling, using as much native JS as possible should provide better performance.
		for (var i = 0; i < inputsLiveNodeList.length; i++) {
			var input = inputsLiveNodeList[i];
			if ((input.type === 'checkbox' || input.type === 'radio') && !$.data(input, PATCHED_DATA_PROP)) {
				patchInput(input);
			}
		}
	}

	$(function() {
		// After refresh, MSIE7-8 restores the checked state of checkboxes on DOM ready without triggering change events,
		// hence we do it here.
		patchNonPatchedInputs();

		// Okay, this is far from ideal, I'd very much prefer an evented or delegated way to do this but it is IMPOSSIBRU.
		// - IE<9 does not support Mutation Events (which would also have terrible performance anyway);
		// - NodeLists don't have any event or method to handle newly added elements (why is it even a live NodeList?);
		setInterval(patchNonPatchedInputs, 200);
	});

}(jQuery));




/*	Checked Polyfill 1.6
 * Provides a .checked class that works like the :checked pseudo class on radio buttons and checkboxes but is available in older browsers such as IE7/8. 
 * https://github.com/rdebeasi/checked-polyfill 
 */

/*

Usage:)
$( document ).ready(function() {
    $('input:radio, input:checkbox').checkedPolyfill();
});
.myStyledLabels label.checked {
    background-color: #ccc; // For older browsers 
}

.myStyledLabels input[type="radio"]:checked + label {
    background-color: #ccc; // For modern browsers 
}


(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD. Register as an anonymous module.
		define(['jquery'], factory);
	} else {
		// Browser globals
		factory(jQuery);
	}
}(function ($) {
	$.fn.checkedPolyfill = function (options) {
		function supportsChecked() {
			// Create a hidden input, style it, and then check to see whether the styles are applied.
			// Inspired by Modernizr's testStyles function
			var $style = $('<style type="text/css"> #checkedPolyfill-test:checked { margin-left: 123456px; display: none; } </style>}'),
				$checkbox = $('<input type="checkbox" checked id="checkedPolyfill-test" />'),
				result;
			$('head').append($style);
			$('body').append($checkbox);
			if ($checkbox.css('margin-left') === '123456px') {
				result = true;
			} else {
				result = false;
			}
			$style.remove();
			$checkbox.remove();
			return result;
		}

		if( supportsChecked() ) {
			// Browser natively supports :checked and doesn't need the polyfill.
			return false;
		}

		function checkValue ($elem) {
			var $label = $('label[for="' + $elem.attr('id') + '"]');
			// TODO: also find labels wrapped around the input
			if ($elem.prop('checked')) {
				$elem.addClass('checked');
				$label.addClass('checked');
			} else {
				$elem.removeClass('checked');
				$label.removeClass('checked');
			}
			// We modify the label as well as the input because authors may want to style the labels based on the state of the chebkox, and IE7 and IE8 don't fully support sibling selectors.
			// For more info: http://www.quirksmode.org/css/selectors/#t11
			return $elem;
		}

		return this.each(function () {
			var $self = $(this);
			if ($self.prop('type') === 'radio') {
				$('input[name="' + $self.prop('name') + '"]').change(function() {
					checkValue($self);
				});
			} else if ($self.prop('type') === 'checkbox') {
				$self.change(function() {
					checkValue($self);
				});
			}
			checkValue($self); // Check value when plugin is first called, in case a value has already been set.
		});
	};
}));
*/

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

