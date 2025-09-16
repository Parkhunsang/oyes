/* FeCommon.js | EUMC
   2019-01-21 initiate
*/
var feUI = feUI || {};
(function(feUI, $, window, document, undefined) {
	'use strict';
	// Common variable
	var $window = $(window),
		$document = $(document),
		$html = $document.find('html').addClass('OL'),
		$body = $document.find('body').on({
			'keydown': function(e) {
				if ( e.keyCode === 9 ) $html.removeClass('OL');
			},
			'keyup': function(e) {
				if ( e.keyCode === 13 ) $html.removeClass('OL');
			},
			'click': function() {
				$html.addClass('OL');
			}
		}),
		$wrap = $body.find('#wrap').append('<div class="dimmedLayer"></div>'),
		$header = $wrap.find('#header').append('<div class="gnbBg"></div>'),
		$gnb = $header.find('#gnb').append('<div class="gnbBar"></div>'),
		$contTopBar = $body.find('.contTopBar'),
		$content = $body.find('#content'),
		$footer = $body.find('#footer'),
		$dimmedLayer = $wrap.find('.dimmedLayer'),
		winWidth = $window.width(),
		winHeight = $window.height(),
		scrollTopPos = $window.scrollTop(),
		headerHeightF = $header.outerHeight(),
		assetDir = '/asset',
		activeClass = 'active',
		checkedClass = 'checked',
		currentClass = 'current',
		eNamespace = '.feUI',
		wrapMinWidth = parseInt($wrap.css('minWidth')),
		wideView = ( winWidth > wrapMinWidth ) ? true : false,
		fixedLayout = false,
		zoomMode = false,
		dimmedOpacity = 0.5,
		aniSpeed = 100,
		playSpeed = 5000,
		isMobView = $html.is('[class*=MobView]'),
		ieVer, gnbLayerMax, templateHTML;
	// Google Web Font Loader
	WebFont.load({
		custom: {
			families: ['Noto Sans KR'],
			urls: ['/css/notosanskr.min.css']
		},
		classes: false,
		active: function() {
			$html.addClass('JS');
		},
		inactive: function() {
			setTimeout(function() {
				$html.addClass('JS');
			}, 1000);
		}
	});
	// jQuery UI Datepicker default setting
	$.datepicker.setDefaults({
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		monthNames: ['01', '02', '03', '04', '05',
					 '06', '07', '08', '09', '10', '11', '12'],
		yearSuffix: '.',
		showOtherMonths: true,
		showMonthAfterYear: true
	});
	//GLOBAL Datepicker default setting
	if ( !$document.find('html').is('[lang=ko]') ) {
		$.datepicker.setDefaults({
			prevText: 'Prev Month',
			nextText: 'Next Month',
			dayNames: ['SUN', 'MON', 'TUE',
				'WED', 'THU', 'FRI', 'SAT'],
			dayNamesMin: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
		});
	}
	// Old IE
	feUI.setOldIE = function() {
		var usrAgent = window.navigator.userAgent,
			msieCheck = usrAgent.match(/MSIE (\d+)/),
			tridentCheck = usrAgent.match(/Trident\/(\d+)/),
			updateURL = 'http://windows.microsoft.com/ko-kr/internet-explorer/download-ie',
			ieInfo = {
				isIE: false,
				trueVer: 0,
				activeVer: 0,
				cpMode: false
			};
		if ( tridentCheck ) { // Check gt IE7
			ieInfo.isIE = true;
			ieVer = ieInfo.trueVer = parseInt(tridentCheck[1], 10) + 4;
		}
		if ( msieCheck ) { // Check lt IE8
			ieInfo.isIE = true;
			ieVer = ieInfo.activeVer = parseInt(msieCheck[1]);
		} else {
			ieInfo.activeVer = ieInfo.trueVer;
		}
		// IE Compatibility Mode(IE8 to IE7)
		if ( ieInfo.isIE && ieInfo.activeVer < 8
			&& ieInfo.trueVer < 9 ) {
			ieInfo.cpMode = ieInfo.trueVer !== ieInfo.activeVer;
		}
		if ( ieInfo.isIE && ieInfo.activeVer < 7 ) window.location = updateURL;
		if ( ieInfo.isIE ) {
			$html.addClass('ie' + ieInfo.activeVer + 'Only');
			if ( ieInfo.trueVer < 9 ) $html.addClass('ie' + ieInfo.trueVer + 'Origin');
		}
		if ( !ieInfo.isIE || ieInfo.activeVer > 8 ) $html.addClass('mdBrowser');
		( ieInfo.cpMode ) ? $html.addClass('cpMode') : $html.removeClass('cpMode');
		return ieInfo;
	};
	feUI.setOldIE();
	feUI.datepickerScope = function(captionVal) {
		var $datepicker = $document.find('.ui-datepicker-calendar'),
			captionTxt = ( captionVal ) ? captionVal : '�щ젰';
		$datepicker.prepend('<caption>' + captionTxt + '</caption>')
			.find('th').attr('scope', 'col');
	};
	// Cookie
	feUI.createCookie = function(name, value, days) {
		var expires;
		if ( days ) {
			var date = new Date();
			date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
			expires = '; expires=' + date.toGMTString();
		} else expires = '';
		document.cookie = name + '=' + value + expires + '; path=/';
	};
	feUI.getCookie = function(name) {
		var nameEQ = name + '=';
		var ca = document.cookie.split(';');
		for ( var i=0; i < ca.length; i++ ) {
			var c = ca[i];
			while ( c.charAt(0) == ' ' ) c = c.substring(1, c.length);
			if ( c.indexOf(nameEQ) == 0 ) return c.substring(nameEQ.length, c.length);
		}
		return null;
	};
	feUI.deleteCookie = function(name) {
		feUI.createCookie(name, '', -1);
	};
	// Get function from string
	feUI.stringToFunc = function(string) {
		var scope = window,
			scopeSplit = string.split('.');
		for ( var i = 0; i < scopeSplit.length - 1; i++ ) {
			scope = scope[scopeSplit[i]];
			if ( scope === undefined ) return;
		}
		return scope[scopeSplit[scopeSplit.length - 1]];
	};
	// Check IE
	feUI.checkIE = function() {
		var usrAgent = window.navigator.userAgent,
			checkMSIE = usrAgent.match(/MSIE (\d+)/),
			checkTrident = usrAgent.match(/Trident\/(\d+)/),
			updateURL = 'http://windows.microsoft.com/ko-kr/internet-explorer/download-ie',
			ieInfo = {
				isIE: false,
				cpMode: false,
				trueVer: undefined,
				activeVer: undefined
			};
		// Check gt IE7(8~edge)
		if ( checkTrident ) {
			ieInfo.isIE = true;
			ieInfo.trueVer = parseInt(checkTrident[1], 10) + 4;
		}
		// Check lt IE8(old~7)
		if ( checkMSIE ) {
			ieInfo.isIE = true;
			ieInfo.activeVer = parseInt(checkMSIE[1]);
		} else {
			ieInfo.activeVer = ieInfo.trueVer;
		}
		// IE Compatibility Mode(IE8 to IE7)
		if ( ieInfo.activeVer < 8 && ieInfo.trueVer < 9 )
			ieInfo.cpMode = ieInfo.trueVer !== ieInfo.activeVer;
		if ( ieInfo.activeVer < 8 ) window.location = updateURL;
		if ( ieInfo.cpMode ) $html.addClass('compMode');
		// Add browser class
		if ( ieInfo.isIE ) {
			$html.addClass('ie' + ieInfo.activeVer + 'Only');
			if ( ieInfo.trueVer < 9 ) $html.addClass('ie' + ieInfo.trueVer + 'Origin');
		}
		return ieInfo;
	};
	feUI.checkIE();
	// Save template
	feUI.saveHTMLTemplate = function(temp) {
		var $htmlTemplate = $wrap.find('.addFormField[data-form-group]');
		if ( !$htmlTemplate.length ) return false;
		templateHTML = templateHTML || {};
		$htmlTemplate.each(function() {
			var $this = $(this),
				groupVal = $this.data('form-group');
			if ( templateHTML[groupVal] ) return true;
			templateHTML[groupVal] = $('<div />').append($this.clone()).html();
		});
		if ( arguments.length !== 0 ) return templateHTML[temp];
	};
	feUI.saveHTMLTemplate();
	// Skip To Content
	feUI.skipToContent = function() {
		var $skipNaviBtn = $body.find('a.skipToContent'),
			tgId = $skipNaviBtn.attr('href');
		if ( !$skipNaviBtn.length ) return false;
		if ( !$content.length ) $skipNaviBtn.hide();
		$skipNaviBtn.on('click', function(e) {
			e.preventDefault();
			$(tgId).attr('tabindex', 0).focus().on('keydown', function(e) {
				if ( e.keyCode === 9 ) $(this).removeAttr('tabindex');
			});
		});
	};
	feUI.skipToContent();
	// header search
	feUI.headSearch = function(){
		var $topSearch = $wrap.find('.totalSearch'),
			$searchBtn = $topSearch.find('.topSearchBtn'),
			$searchBar = $topSearch.find('.search'),
			$searchClose = $topSearch.find('.button-close');
		$searchBtn.off().on('click', function(){
			$searchBar.show();
		});
		$searchClose.off().on('click', function(){
			$searchBar.hide();
			$searchBar.find('input').val('');
		})
	}
	feUI.headSearch();
	// Document tile
	feUI.documentTitle = function(){
		var $conTitle = $content.find('.heading-depth01 .title')
				.filter(':visible:first'),
			conTitleValue = $conTitle.text(),
			docTitle = $document.attr('title');
		( !$conTitle.length )
			? $document.attr('title', docTitle)
			: $document.attr('title', conTitleValue + ' | ' + docTitle);
	};
	feUI.documentTitle();
	// Disable invalid alert
	feUI.disableInvalid = function() {
		var $requiredEl = $content.find('[required]');
		if ( !$requiredEl.length ) return false;
		$requiredEl.on('invalid', function(e) {
			e.preventDefault();
		});
	};
	feUI.disableInvalid();
	// Placeholder
	feUI.placeholder = function() {
		var $placeholderInp = $('[placeholder]'),
			placeholderClass = 'placeholder',
			phSupported = document.createElement('input').placeholder !== undefined,
			ieActiveVer = feUI.checkIE().activeVer;
		if ( phSupported ) return false;
		$placeholderInp.each(function() {
			var $this = $(this),
				type = $this.attr('type'),
				phTxt = $this.attr('placeholder');
			if ( ieActiveVer > 8 && type === 'password' ) $this.attr('type', 'text');
			if ( $this.val() === '' ) $this.addClass(placeholderClass).val(phTxt);
			$this.on({
				'focus': function() {
					if ( ieActiveVer > 8 && type === 'password' )
						$this.attr('type', 'password');
					if ( $this.val() === phTxt )
						$this.val('').removeClass(placeholderClass);
				},
				'focusout': function() {
					if ( $this.val() === '' || $this.val() === phTxt ) {
						$this.val('').addClass(placeholderClass);
						( ieActiveVer > 8 && type === 'password' )
							? $this.attr('type', 'text').val(phTxt)
							: $this.val(phTxt);
					}
				}
			});
		});
	};
	feUI.placeholder();
	// feForm
	feUI.setFormEl = function() {
		var $formEl = $wrap.find(':radio, :checkbox, :file'),
			exFilter = $('.he, .originType, .fileTxt :file');
		if ( !$formEl.length ) return false;
		$formEl.not(exFilter).feForm();
	};
	feUI.setFormEl();
	// Focus rotation(jQuery UI :focusable required)
	feUI.focusRotation = function(evtTg, tgWrap, closeBtn) {
		var $tgWrap = tgWrap,
			$firstFocusTg = $tgWrap.find(':focusable:first'),
			$lastFocusTg = $tgWrap.find(':focusable:last');
		$tgWrap.attr('tabindex', 0).focus().on('keydown', function(e) {
			var $this = $(this);
			if ( !$(e.target).is(tgWrap) ) return;
			if ( e.keyCode === 9 && e.shiftKey ) {
				e.preventDefault();
				$this.removeAttr('tabindex');
				( closeBtn ) ? closeBtn.focus() : $lastFocusTg.focus();
			} else if ( e.keyCode === 9 && !e.shiftKey ) {
				e.preventDefault();
				$this.removeAttr('tabindex');
				$firstFocusTg.focus();
			}
		});
		$firstFocusTg.off('keydown').on('keydown', function(e) {
			if ( e.keyCode === 9 && e.shiftKey ) {
				e.preventDefault();
				( closeBtn ) ? closeBtn.focus() : $lastFocusTg.focus();
			}
			if ( ( e.keyCode === 9 && !e.shiftKey )
				&& ( $firstFocusTg.is($lastFocusTg) ) ) {
				e.preventDefault();
			}
		});
		$lastFocusTg.off('keydown').on('keydown', function(e) {
			if ( e.keyCode === 9 && !e.shiftKey ) {
				e.preventDefault();
				( closeBtn ) ? closeBtn.focus() : $firstFocusTg.focus();
			}
			if ( ( e.keyCode === 9 && e.shiftKey )
				&& ( $firstFocusTg.is($lastFocusTg) ) ) {
				e.preventDefault();
			}
		});
	};
	// Breadcrumb
	feUI.breadcrumb = function() {
		var $breadcrumb = $contTopBar.find('.breadcrumb'),
			$bcLinkLayerBtn = $breadcrumb.find('.bcLinkLayerBtn'),
			$bcLinkLayer = $breadcrumb.find('.bcLinkLayer').attr({
				'role': 'region',
				'aria-hidden': true,
				'aria-expanded': false
			}),
			btnOpenTxt = '열기',
			btnCloseTxt = '닫기',
			$tgBcLinkLayer;
		if ( !$breadcrumb.length ) return false;
		$bcLinkLayerBtn.on({
			'click': function() {
				var $this = $(this),
					tgOpenTxt = $this.text().replace(btnOpenTxt, btnCloseTxt),
					tgCloseTxt = $this.text().replace(btnCloseTxt, btnOpenTxt);
				$tgBcLinkLayer = $this.siblings().filter($bcLinkLayer);
				if ( $this.hasClass(activeClass) ) {
					$tgBcLinkLayer.stop().slideUp(aniSpeed, function() {
						$(this).attr({
							'aria-hidden': true,
							'aria-expanded': false
						});
					});
					$this.text(tgCloseTxt).removeClass(activeClass)
						.parent('.item').removeClass(activeClass);
				} else {
					$tgBcLinkLayer.stop().slideDown(aniSpeed, function() {
						$(this).attr({
							'aria-hidden': false,
							'aria-expanded': true
						});
					});
					$this.text(tgOpenTxt).addClass(activeClass)
						.parent('.item').addClass(activeClass);
					feUI.focusRotation($this, $tgBcLinkLayer, $this);
				}
			},
			'keydown': function(e) {
				if ( !$tgBcLinkLayer || $tgBcLinkLayer.is(':hidden') ) return;
				if ( e.keyCode === 9 && !e.shiftKey ) {
					e.preventDefault();
					$tgBcLinkLayer.find(':focusable:first').focus();
				} else if ( e.keyCode === 9 && e.shiftKey ) {
					e.preventDefault();
					$tgBcLinkLayer.find(':focusable:last').focus();
				}
			}
		});
		$wrap.on('click', function(e) {
			if ( !$(e.target).is($bcLinkLayerBtn) )
				$bcLinkLayerBtn.filter('.' + activeClass).trigger('click');
		});
	};
	feUI.breadcrumb();
	// select menu
	feUI.selectMenu = function() {
		var $selectMenu = $wrap.find('.selectMenu'),
			$selectBtn = $selectMenu.find(' > button');
		if ( !$selectBtn.length ) return false;
		$selectBtn.on('click', function() {
			$(this).toggleClass(activeClass);
			$(this).next().slideToggle(aniSpeed);
		});
	};
	feUI.selectMenu();
	// disabled Input
	feUI.disabledInp = function() {
		var $formField = $wrap.find('.formField'),
			$formRadio = $formField.find(':radio'),
			$radioJs = $formRadio.filter('.radioJs'),
			$etcInp = $formField.find('.inputJs'),
			$etcSelect = $formField.find('.etcSelect');
		if ( !$formField.length ) return false;
		$formRadio.on('change', function() {
			var $this = $(this),
				$optionGroup = $this.closest('td'),
				$etcSelect = $optionGroup.find('.etcSelect');
			if($optionGroup.find($radioJs).prop('checked') ) {
				$optionGroup.find($etcInp).prop('disabled', false);
				$optionGroup.find($etcSelect).removeClass('disabled');
				$etcSelect.find('select').prop('disabled', false);
				feUI.disabledSelect();
			} else {
				$optionGroup.find($etcInp).prop('disabled', true);
				$optionGroup.find($etcSelect).addClass('disabled');
				$etcSelect.find('select').prop('disabled', true);
				$etcSelect.find('select option:eq(0)').prop('selected', true).trigger('change');
				$('.etcInp').val('').hide();
			}
		});
	};
	feUI.disabledInp();
	// disabledSelect
	feUI.disabledSelect = function() {
		var $formField = $wrap.find('.formField'),
			$etcInp = $formField.find('.etcInp'),
			$formSelect = $formField.find('.etcSelect');
		if ( !$formField.length ) return false;
		if ( $formSelect.find('select option:selected').text() == '기타' ) {
			$etcInp.show();
			$(this).find('select').prop('disabled', false);
		} else {
			$etcInp.hide();
		}
		$formSelect.on('change', function() {
			( $formSelect.find('select option:selected').text() == '기타' )
			? $etcInp.show()
			: $etcInp.hide();
		});
	};
	feUI.disabledSelect();
	// number Comma Input
	feUI.numCommaInp = function() {
		var  $formField = $wrap.find('.formField'),
			 $commaInp = $formField.find('.commaInpJs');
		if ( !$commaInp.length ) return false;
		$commaInp.on('keyup', function() {
			var $this = this;
			numberFormat($this);
		});
		function comma(str) {
			str = String(str);
			return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		}
		function uncomma(str) {
			str = String(str);
			return str.replace(/[^\d]+/g, '');
		}
		function numberFormat(obj) {
			obj.value = comma(uncomma(obj.value));
		}
	};
	feUI.numCommaInp();
	// Number Check Input
	feUI.onlyNumInp = function(){
		var $iptNum = $wrap.find('input[title*="숫자만"]')
						.add('input[title*="전화번호"]').add('input[title*="연락처"]');
		if ( !$iptNum.length ) return false;
		$iptNum.keyup(function(){
			var $this = $(this);
			$this.val( $this.val().replace(/[^0-9]/g,""));
			$this.attr('maxlength', '11');
		});
	};
	feUI.onlyNumInp();
	// select reset
	feUI.selectGt = function(){
		var $selectFirst = $wrap.find('select[data-select-reader]'),
			$selectGroup = $wrap.find('select[data-select-group]');
		$selectFirst.on('change', function(){
			$selectGroup.not($selectFirst).trigger('feReset');
		});
	};
	feUI.selectGt();
	// feFAQ
	feUI.setFAQList = function() {
		var $faqList = $wrap.find('.accordion');
		if ( !$faqList.length ) return false;
		$faqList.feFAQ();
	};
	feUI.setFAQList();
	// partListLink
	feUI.partListLink = function() {
		var $partItemWrap = $content.find('.partList .partItem'),
			$partList = $partItemWrap.find('.hover').css({
				'z-index': 0,
				'opacity': 0,
				'height': 0,
				'min-height': 0
			});
		if ( !$partItemWrap.length ) return false;
		$partItemWrap.each(function() {
			var $this = $(this),
				$tgPartList = $this.find($partList),
				partCode = $this.find('span').html();
			$tgPartList.prepend('<em>' + partCode + '</em>');
		}).on({
			'mouseenter focusin': function(e) {
				e.stopPropagation();
				toggleAni(e);
			}
		});
		$partList.on({
			'mouseleave focusout': function(e) {
				toggleAni(e);
			}
		});
		function toggleAni(e) {
			var $this = $(e.target).closest($partItemWrap),
				$tgPartList = $this.find($partList),
				inEvent = e.type === 'mouseenter' || e.type === 'focusin';
			if ( inEvent ) {
				$this.css('z-index', 1);
				$tgPartList.css({
					'z-index': 1,
					'height': 'auto',
					'min-height': 213
				}).stop().animate({
					'opacity': 1
				}, aniSpeed, function() {
					$partList.not($tgPartList).trigger('mouseleave');
				});
			} else {
				$tgPartList.stop().animate({
					'opacity': 0
				}, aniSpeed/2, function() {
					$tgPartList.css({
						'z-index': 0,
						'height': 0,
						'min-height': 0
					});
					$this.css('z-index', 0);
				});
			}
		}
	};
	feUI.partListLink();
	// mainSlide
	feUI.mainSlide = function(){
		var $mainSlideWrap = $wrap.find('.mainSlideWrap'),
			$mainSlide = $mainSlideWrap.find('.mainSlide');
		if ( $mainSlide.find('> div').length == 1 ) return false;
		$mainSlide.bxSlider({
			controls: false,
			auto: true,
			autoControls: true,
			autoControlsCombine: true,
			touchEnabled: false,
			stopAutoOnClick: true
		});
		$mainSlideWrap.find('.bx-controls').append($mainSlideWrap.find('.bx-controls-auto'));
	};
	feUI.mainSlide();
	// mainMovie
	var $mainMovie = $wrap.find('.healthSlideMovie'),
		$mainMovieSlide = $mainMovie.find('> ul');
		$mainMovieSlide.bxSlider({
			controls: false,
			minSlides: 3,
			maxSlides: 3,
			slideMargin: 41,
			slideWidth: 372,
			touchEnabled: false
		});
	// mainFunSlide
	feUI.mainFunSlide = function(){
		var $funSlideWrap = $wrap.find('.fund-mainslide'),
			$funSlide = $funSlideWrap.find('> ul');
		$funSlide.find('> li:last-child').prependTo($funSlide);
		$funSlide.bxSlider({
			controls: false,
			auto: true,
			autoControls: true,
			autoControlsCombine: true,
			minSlides: 3,
			maxSlides: 3,
			moveSlides: 1,
			slideWidth: 1200,
			slideMargin: 30,
			touchEnabled: false,
			onSlideBefore: function (currentSlideNumber, totalSlideQty, currentSlideHtmlObject) {
				$('.active').removeClass('active');
				$('.bx-viewport > ul > li').eq(currentSlideHtmlObject + 4).addClass('active');
			},
			onSliderLoad: function () {
				$('.bx-viewport > ul > li').eq(4).addClass('active');
		   }
		});
		$funSlideWrap.find('.bx-controls').append($funSlideWrap.find('.bx-controls-auto'));
	};
	feUI.mainFunSlide();
	// mainFunPay
	feUI.mainFunPay = function(){
		var mainFunPay = $wrap.find('.sup-list'),
			mainFunPaySlide = mainFunPay.find('> ul');
		mainFunPaySlide.bxSlider({
			mode: 'vertical',
			auto: true,
			autoControls: true,
			autoControlsCombine: true,
			pager: false,
			touchEnabled: false
		});
	};
	feUI.mainFunPay();
	// gallery
	feUI.gallery = function(){
		var thumbSlideView = $('.thumb-slide-view > ul').bxSlider({
			controls: false,
			touchEnabled: false,
			mode: 'fade',
			pagerCustom: '.thumb-slide > ul',
			onSlideBefore: function($slideElement, oldIndex, newIndex) {
				thumbSlide.goToSlide(newIndex);
			}
		});
		var thumbSlide = $('.thumb-slide > ul').bxSlider({
			pager: false,
			minSlides: 4,
			maxSlides: 4,
			moveSlides: 1,
			infiniteLoop: false,
			slideWidth: 180,
			slideMargin: 40,
			touchEnabled: false,
			onSlideNext: function($slideElement, oldIndex, newIndex) {
				thumbSlideView.goToSlide(newIndex);
			},
			onSlidePrev: function($slideElement, oldIndex, newIndex) {
				thumbSlideView.goToSlide(newIndex);
			}
		});
	};
	feUI.gallery();
	// feSlide
	feUI.setSlideEl = function() {
		var $gallerySlide = $wrap.find('.gallerySlide'),
			$loanSlide = $wrap.find('.loanSlide');
		$gallerySlide.feSlide({
			fixedLayout: false,
			pagingBtn: false,
			aniSpeed: aniSpeed * 4,
			afterAnimate: function() {
				var $modal = $gallerySlide.parents('.modal'),
					$modalTItle = $modal.find('.galleryTitle'),
					imgName = $gallerySlide.find('.current img').attr('alt');
				$modalTItle.text(imgName);
			}
		});
		$loanSlide.feSlide({
			fixedLayout: false,
			pagingBtn: false,
			aniSpeed: aniSpeed * 4,
		});
	};
	feUI.setSlideEl();
	// setTabEl
	feUI.setTabEl = function() {
		var $feTab = $wrap.find('.tabJs'),
			exFilter = $('.tabNone');
		if ( !$feTab.length ) return false;
		$feTab.not(exFilter).feTab();
	};
	feUI.setTabEl();
	// mainNotice
	feUI.mainNotice = function() {
		var $mainNoticeTab = $wrap.find('.mainTab.noticeTab');
		if ( !$mainNoticeTab.length ) return false;
		$mainNoticeTab.feTab();
	};
	//feUI.mainNotice();
	// schedule modal toggle
	feUI.schModalList = function() {
		var $modalWrap = $wrap.find('.modal-schedule'),
			$treatView = $modalWrap.find('.treatView'),
			$list= $treatView.find('.list'),
			$btnOpen = $treatView.find('.btnListOpen'),
			$btnClose = $treatView.find('.btnListClose');
		if ( !$modalWrap.length ) return false;
		$btnOpen.on('click', function() {
			$list.slideDown(aniSpeed);
		});
		$btnClose.on('click', function() {
			$list.slideUp(aniSpeed);
		});
		$('.treatView li a').on('click', function(e){
			e.preventDefault();
			var $this = $(this),
				$target = $($this.attr('href'));
			$list.slideUp(aniSpeed);
			if ( !$target.length ) return false;
			$('.modal-schedule .scroll').scrollTop(0).stop().animate({
				scrollTop: $target.offset().top - $('.modal-schedule .scroll').offset().top
			});
		});
	};
	feUI.schModalList();
	// filterToggle
	feUI.filterToggle = function() {
		var $boardHead = $wrap.find('.boardHead'),
			$btnFilter = $boardHead.find('.btnFilter'),
			$filterWrap = $boardHead.find('.filter');
		if ( !$btnFilter.length ) return false;
		$btnFilter.on('click', function() {
			$(this).add($filterWrap).toggleClass(activeClass);
		});
	};
	feUI.filterToggle();
	// Bookmark link in knowledgeContent (DEPT)
	feUI.contBookmark = function() {
		var $knowCont = $content.filter('.knowledgeContent'),
			$bookmarkLink = $knowCont.find('.contLinkJs a'),
			$bookmarkTitle = $knowCont.find('.contLinkWrap');
		if ( !$bookmarkTitle.length ) return false;
		$bookmarkLink.on('click', function(e) {
			var $this = $(this),
				idx = $bookmarkLink.index($this);
			e.preventDefault();
			$html.add($body).stop().animate({
				scrollTop: $bookmarkTitle.eq(idx).offset().top - 200
			});
		});
	};
	//feUI.contBookmark();
	// filter accordion (RECRUIT / CLINICAL)
	feUI.filterAccordion = function() {
		var $faqList = $wrap.find('.filterWrap');
		if ( !$faqList.length ) return false;
		$faqList.feFAQ({
			questionEl: '.button',
			answerEl: '.filter'
		});
	};
	feUI.filterAccordion();
    // Accordion table
    feUI.accordionTbl = function(item) {
        var $accTbl = $body.find('.accordion-table');
        if (!$accTbl.length) {
            return;
        }
    
        $accTbl.on('click', '.button-detail', function(e) {
            var $this = $(this),
                $tgRow = $this.closest('tr'),
                $tgContRow = $tgRow.next('tr');
            
            e.preventDefault();
    
            // 토글 클래스를 적용하고, 그 결과를 확인하여 텍스트를 변경
            $tgRow.toggleClass(activeClass);
            $this.toggleClass(activeClass);
            $tgContRow.toggleClass(activeClass);
    
            var isOpen = $tgRow.hasClass(activeClass);
            var newTitle = isOpen ? '닫기' : '열기';
            
            if ($this.is('.button-detail01')) {
                $this.attr('title', newTitle);
            } else {
                $this.find('span').text(newTitle);
            }
        });
    
        if (item) {
            $accTbl.each(function() {
                var $targetBtn = $(this).find('.button-detail').eq(item - 1);
                if ($targetBtn.length) {
                    $targetBtn.trigger('click');
                }
            });
        }
    };	
	feUI.accordionTbl();
	// Main Schedule Table td nthChild StyleSet (MUSICALE)
	feUI.nthchild = function() {
		var $nthchild = $content.find('.mainSchedule tbody tr td');
		if ( !$nthchild.length ) return false;
		$nthchild.filter(':nth-child(6n), :nth-child(7n)').addClass('nth');
	};
	feUI.nthchild();
	// Main Schedule Detail Toggle (MUSICALE)
	feUI.detailToggle = function() {
		var $detailBtn = $content.find('.mainSchedule .btnDetail'),
			$detailWrap = $content.find('.mainSchedule .detail'),
			$closeBtn = $detailWrap.find('.close');
		if ( !$detailBtn.length ) return false;
		$detailBtn.on('click', function(e){
			e.preventDefault();
			var $this = $(this);
			$detailWrap.fadeOut(aniSpeed);
			$this.siblings('.detail').fadeIn(aniSpeed);
		});
		$document.on('click', '.detail .close', function(){
			$detailWrap.fadeOut(aniSpeed);
		});
		$document.on('click', '.detail .closeBtn', function(){
		  $detailWrap.fadeOut(aniSpeed);
	   });
	};
	feUI.detailToggle();
	// Replace image (Mobile LayerGuide)
	feUI.replaceImageGuide = function(){
		var $replaceSelect = $wrap.find('select').has('option[data-rp-img]'),
			$replaceImgWrap = $wrap.find('.replaceImgWrap'),
			$replaceImg = $replaceImgWrap.find('img'),
			$ctgSelect = $wrap.find('.ctgSelect');
		// select
		$replaceSelect.on('change', function() {
			var $this = $(this),
				$tgOption = $this.find('option:selected'),
				imgSrc = $tgOption.data('rp-img'),
				errorMsg = $tgOption.data('alert'),
				imgAlt = ( $tgOption.is('[data-rp-alt]') )
					? $tgOption.data('rp-alt') : $tgOption.text();
			if ( $tgOption.is('[data-alert]') ) {
				errorMsg = $tgOption.data('alert');
				$replaceImgWrap.text(errorMsg);
				return false;
			}
			$replaceImg.attr('src', imgSrc).attr('alt', imgAlt);
		});
		//ctgSelect
		$ctgSelect.on('change', function() {
			$replaceSelect.filter(':visible').trigger('change');
		});
	};
	// select option change (RECRUIT modal-apply)
	feUI.optChangeSel = function(){
		$('.optSelect').on('change', function(){
			var $form = $wrap.find('.optViewForm'),
					$inp = $form.find('.inpWrap'),
					$select = $form.find('.selWarp');
			if( $('.optSelect option:selected').text() == '직접입력' ) {
				$inp.show();
				$select.hide();
			} else {
				$inp.hide();
				$select.show();
			}
		});
	};
	feUI.optChangeSel();
	// 媛쒖씤嫄닿컯寃�吏� �덉빟 �꾨줈洹몃옩 �좏깮
	feUI.prgItem = function() {
		var $prgItem = $wrap.find('.prg-item'),
			$target = $prgItem.find('.prg-head');
		$target.off().on('click', function(e){
			e.preventDefault();
			var $this = $(this);
			$this.toggleClass(currentClass);
			$target.not($this).removeClass(currentClass);
		});
	};
	feUI.prgItem();
	// tooltip
	feUI.tooltip = function() {
		var $toolTip = $wrap.find('.toolTip'),
			$toolTipBtn = $toolTip.find('.btn'),
			$toolTipText = $toolTip.find('.text');
		$toolTipText.hide();
		$toolTipBtn.off().on('click', function(e){
			var $this = $(this),
				$myToolTip = $this.next('.text');
			e.preventDefault();
			$toolTipText.not($myToolTip).hide();
			$myToolTip.toggle();
		});
	};
	feUI.tooltip();
	// Default function
	feUI.defaultFuncSet = function() {
		feUI.tooltip();
		feUI.setFormEl();
		// feUI.contTab();
		feUI.setFAQList();
		feUI.selectElMethod.init();
	};
	// Util Buttons
	feUI.utilBtnMethod = {
		tgEl: {},
		init: function() {
			var tgEl = feUI.utilBtnMethod.tgEl;
			tgEl.$contUtilMenu = $wrap.find('.utilMenu');
			if ( !tgEl.$contUtilMenu.length ) return false;
			feUI.utilBtnMethod._copyBtn();
			feUI.utilBtnMethod._zoomBtn();
			feUI.utilBtnMethod._printBtn();
		},
		_printBtn: function() {
			var tgEl = feUI.utilBtnMethod.tgEl,
				$printBtn = tgEl.$contUtilMenu.find('.print');
			if ( $.browser.mobile ) return false;
			$printBtn.show().on('click', function(e) {
				e.preventDefault();
				window.print();
			});
		},
		_copyBtn: function() {
			var tgEl = feUI.utilBtnMethod.tgEl,
				$copyBtn = tgEl.$contUtilMenu.find('.copyURL');
			if ( $.browser.mobile ) return false;
			$copyBtn.show().on('click', function(e) {
				var urlString = window.location.href;
				e.preventDefault();
				copyToClipboard(urlString);
			});
			function copyToClipboard(tgVal) {
				var $tempInp = $('<input type="text">');
				$body.append($tempInp);
				$tempInp.val(tgVal).select();
				document.execCommand('copy');
				$tempInp.remove();
				$copyBtn.focus();
				alert('주소가 복사되었습니다.');
			}
		},
		_zoomBtn: function() {
			var tgEl = feUI.utilBtnMethod.tgEl,
				$zoomBtnList = tgEl.$contUtilMenu.find('[class*=zoom]'),
				$zoomInBtn = $zoomBtnList.filter('.zoomIn').find('button'),
				$zoomOutBtn = $zoomBtnList.filter('.zoomOut').find('button'),
				$defaultBtn = $zoomBtnList.filter('.zoomDefault').find('button'),
				zoomVal = 1,
				zoomStep = 0.25;
			if ( ieVer < 8 || $.browser.mobile ) return false;
			if ( zoomVal === 1 ) $zoomOutBtn.add($defaultBtn).prop('disabled', true);
			$zoomBtnList.show().on('click', 'button', function() {
				var $this = $(this);
				if ( $this.is($zoomInBtn) ) {
					zoomVal = zoomVal + zoomStep;
				} else if ( $this.is($zoomOutBtn) ) {
					zoomVal = zoomVal - zoomStep;
				} else {
					zoomVal = 1;
				}
				if ( zoomVal !== 1 ) {
					zoomMode = true;
					$zoomOutBtn.add($defaultBtn).prop('disabled', false);
				} else {
					zoomMode = false;
					$zoomOutBtn.add($defaultBtn).prop('disabled', true);
				}
				$body.css({
					'zoom': zoomVal,
					'-o-transform': 'scale(' + zoomVal + ', ' + zoomVal + ')',
					'-o-transform-origin': 'left top',
					'-moz-transform-origin': 'left top',
					'-moz-transform': 'scale(' + zoomVal + ', ' + zoomVal + ')'
				});
			});
		}
	};
	feUI.utilBtnMethod.init();
	// header
	feUI.headerMethod = {
		tgEl: {},
		init: function() {
			var tgEl = feUI.headerMethod.tgEl;
			tgEl.hasLnbLayer = $header.hasClass('hasLnbLayer'),
			tgEl.$depth01 = $gnb.find('.gnbList'),
			tgEl.$depth01Anchor = tgEl.$depth01.find('> li > a'),
			tgEl.$gnbLayer = ( !tgEl.hasLnbLayer )
				? $gnb.find('[class*=sub-item]').attr({
					'role': 'region',
					'aria-hidden': true,
					'aria-expanded': false
				})
				: $gnb.find('.lnbLayerWrap').attr({
					'role': 'region',
					'aria-hidden': true,
					'aria-expanded': false
				}),
			tgEl.$gnbLayerBg = $header.find('.gnbBg'),
			tgEl.$gnbBg = $gnb.find('.gnbBar'),
			tgEl.totSearchLayer = $wrap.find('.totSearchLayer').attr({
					'aria-hidden': true,
					'aria-expanded': false
				}),
			tgEl.gnbLayerHeight = ( !tgEl.hasLnbLayer )
				? tgEl.$gnbLayer.map(function() {
					return $(this).height();
				}).get()
				: tgEl.$gnbLayer.outerHeight(true);
			tgEl.aniSpeed = aniSpeed;
			if ( !tgEl.hasLnbLayer ) {
				gnbLayerMax = Math.max.apply(Math, tgEl.gnbLayerHeight);
				tgEl.$gnbLayer.each(function(idx) {
					$(this).find('> [class*=gnbLayerCo]').css('height', tgEl.gnbLayerHeight[idx]);
				});
			} else {
				gnbLayerMax = tgEl.gnbLayerHeight;
				tgEl.$gnbLayer.find('> ul > li').height(tgEl.gnbLayerHeight);
			}
			feUI.headerMethod._gnbLayer();
			feUI.headerMethod._languageLayer();
		},
		_gnbBg: function(tgIdx) {
			var tgEl = feUI.headerMethod.tgEl,
				depth1AnchorWidth = tgEl.$depth01Anchor.map(function() {
					return Math.round($(this).width());
				}).get(),
				depth1AnchorPos = tgEl.$depth01Anchor.map(function() {
					return Math.round($(this).position().left);
				}).get();
			( !$gnb.hasClass(activeClass) )
				? tgEl.$gnbBg.show().css({
					left: depth1AnchorPos[tgIdx],
					width: depth1AnchorWidth[tgIdx] + 2,
					opacity: 0
				}).stop().animate({
					opacity: 1
				}, tgEl.aniSpeed)
				: tgEl.$gnbBg.show().stop().animate({
					left: depth1AnchorPos[tgIdx],
					width: depth1AnchorWidth[tgIdx] + 2,
					opacity: 1
				}, tgEl.aniSpeed);
		},
		_gnbLayer: function() {
			var tgEl = feUI.headerMethod.tgEl;
			tgEl.$depth01Anchor.on({
				'focusin mouseenter': function() {
					var $this = $(this),
						$tgLayer = ( !tgEl.hasLnbLayer )
							? $this.siblings(tgEl.$gnbLayer)
							: tgEl.$gnbLayer,
						$langCloseBtn = $header.find('.languageLayer .layerCloseBtn button'),
						tgIdx = tgEl.$depth01Anchor.index($this),
						tgLayerHeight = ( !tgEl.hasLnbLayer )
							? tgEl.gnbLayerHeight[tgIdx]
							: tgEl.gnbLayerHeight,
						gnbLayerBgHeight = tgEl.$gnbLayerBg.height(),
						$tgActive = $this.add($header).add($tgLayer).add(tgEl.$gnbLayerBg),
						$tgInActive = ( !tgEl.hasLnbLayer )
							? tgEl.$depth01Anchor.not($this).add(tgEl.$gnbLayer).not($tgLayer)
							: tgEl.$depth01Anchor.not($this);
					if ( $this.hasClass(activeClass) ) return false;
					$tgActive.addClass(activeClass);
					$tgInActive.removeClass(activeClass);
					if ( $header.hasClass('noGnbLayer') ) return false;
					feUI.headerMethod._gnbBg(tgIdx);
					tgEl.$gnbLayer.hide().attr({
						'aria-hidden': true,
						'aria-expanded': false
					});
					if ( $langCloseBtn.is(':visible') ) $langCloseBtn.trigger('click');
					if ( !$gnb.hasClass(activeClass) ) {
						$gnb.addClass(activeClass);
						$tgLayer.add(tgEl.$gnbLayerBg).css('opacity', 0);
					} else {
						$tgLayer.add(tgEl.$gnbLayerBg).css('opacity', 1);
					}
					$tgLayer.css('height', gnbLayerBgHeight).attr({
						'aria-hidden': false,
						'aria-expanded': true
					});
					$tgLayer.add(tgEl.$gnbLayerBg).show().stop().animate({
						height: tgLayerHeight,
						opacity: 1
					}, tgEl.aniSpeed);
				}
			});
			$header.on('mouseleave', closeLayer);
			$wrap.on('click', function(e) {
				if ( !$(e.target).closest($header).length ) closeLayer();
			});
			function closeLayer() {
				if ( $gnb.has('.feFoSelect.active').length > 0 ) return false;
				tgEl.$depth01Anchor.removeClass(activeClass);
				if ( $gnb.hasClass('blogMenu') ) $gnb.removeClass(activeClass);
				tgEl.$gnbLayer.add(tgEl.$gnbLayerBg).animate({
					height: 0,
					opacity: 0
				}, tgEl.aniSpeed, function() {
					tgEl.$gnbLayer.hide().attr({
						'aria-hidden': true,
						'aria-expanded': false
					});
					tgEl.$gnbLayerBg.hide();
					$gnb.add(tgEl.$gnbLayer).add(tgEl.$gnbLayerBg)
						.removeClass(activeClass);
				});
				tgEl.$gnbBg.stop().fadeOut(tgEl.aniSpeed);
			}
		},
		_languageLayer: function() {
			var tgEl = feUI.headerMethod.tgEl,
				$languageBtn = $header.find('.languageBtn > a[role=button]'),
				$languageLayer = $languageBtn
					.siblings('ul').attr({
						'aria-hidden': true,
						'aria-expanded': false
					}),
				$closeBtn = $languageLayer.find('.layerCloseBtn');
			$languageBtn.add($closeBtn).on({
				'click': function(e) {
					var $this = $(this);
					e.preventDefault();
					$header.trigger('mouseleave');
					if ( $this.is($languageBtn) ) {
						if ( $this.next().is(':visible') ) {
							$(this).next().attr({
								'aria-hidden': true,
								'aria-expanded': false
							}).fadeOut();
							$(this).removeClass(activeClass);
						} else {
							$(this).next().attr({
								'aria-hidden': false,
								'aria-expanded': true
							}).fadeIn();
							$(this).addClass(activeClass);
						}
					}
					feUI.focusRotation($this, $languageLayer);
				}
			});
			function closeLayer(evtTg) {
				$languageLayer.stop().fadeOut(tgEl.aniSpeed, function() {
					$(this).attr({
						'aria-hidden': true,
						'aria-expanded': false
					});
				});
				if ( arguments.length > 0 ) setTimeout(function() {
					evtTg.focus();
				});
			}
		}
	};
	feUI.headerMethod.init();
	// Fixed layout
	feUI.fixedLayoutMethod = {
		tgEl: {},
		init: function() {
			var tgEl = feUI.fixedLayoutMethod.tgEl;
			tgEl.contTopBarHeight = $contTopBar.height();
			// Notice banner
			feUI.fixedLayoutMethod.noticeBanner();
			// Check
			if ( winHeight <= headerHeightF * 3 + tgEl.noticeBnrHeight
				|| winHeight <= gnbLayerMax + headerHeightF + tgEl.noticeBnrHeight
				|| zoomMode ) {
				$header.add($contTopBar).css('position', 'absolute');
				$header.css('top', tgEl.noticeBnrHeight);
				$contTopBar.css('top', headerHeightF + tgEl.noticeBnrHeight);
				return false;
			}
			feUI.fixedLayoutMethod._setHeader();
		},
		noticeBanner: function() {
			var tgEl = feUI.fixedLayoutMethod.tgEl,
				$noticeBnr = ( $wrap.find('.noticeSlide').length )
					? $wrap.find('.noticeSlide')
					: $wrap.find('.noticeBannerWrap'),
				cookieName = 'nbnr';
			// Check cookie
			if ( feUI.getCookie(cookieName) === '1' ) $noticeBnr.hide();
			tgEl.noticeBnrHeight = ( $noticeBnr.filter(':visible').length )
				? $noticeBnr.height() : 0;
			$noticeBnr.off('click').on('click', '.closeBtn', function(e) {
				e.preventDefault();
				$noticeBnr.slideUp(aniSpeed);
				$header.stop().animate({
					top: 0
				}, aniSpeed);
				$contTopBar.stop().animate({
					top: headerHeightF
				}, aniSpeed);
			});
			// .off('change').on('change', ':checkbox', function() {
			// 	var checked = $(this).prop('checked');
			// 	( checked )
			// 		? feUI.createCookie(cookieName, 1, 1)
			// 		: feUI.deleteCookie(cookieName);
			// });
		},
		_setHeader: function() {
			var	tgEl = feUI.fixedLayoutMethod.tgEl,
				$languageLayer = $header.find('.languageLayer'),
				setAniSpeed = aniSpeed * 0,
				headerTopPos, contTopBarTopPos;
			if ( scrollTopPos >= headerHeightF
				&& $languageLayer.is(':visible') )
				$languageLayer.stop().fadeOut(feUI.headerMethod.tgEl.aniSpeed);
			if ( wideView ) {
				$header.add($contTopBar).css('position', 'fixed');
				if ( tgEl.noticeBnrHeight > 0 ) {
					if ( scrollTopPos < tgEl.noticeBnrHeight ) {
						headerTopPos = tgEl.noticeBnrHeight - scrollTopPos,
						contTopBarTopPos = headerHeightF + headerTopPos;
					} else {
						headerTopPos = 0,
						contTopBarTopPos = headerHeightF;
					}
				} else {
					headerTopPos = 0,
					contTopBarTopPos = headerHeightF;
				}
			} else {
				$header.add($contTopBar).css('position', 'absolute');
				if ( tgEl.noticeBnrHeight > 0 ) {
					if ( scrollTopPos < tgEl.noticeBnrHeight ) {
						headerTopPos = tgEl.noticeBnrHeight,
						contTopBarTopPos = headerHeightF + headerTopPos;
					} else {
						headerTopPos = scrollTopPos,
						contTopBarTopPos = headerHeightF + scrollTopPos;
					}
				} else {
					headerTopPos = scrollTopPos,
					contTopBarTopPos = headerHeightF + scrollTopPos;
				}
			}
			$header.stop().animate({
				top: headerTopPos
			}, setAniSpeed, function() {
				( headerTopPos === 0 ) ? fixedLayout = false : fixedLayout = true;
			});
			$contTopBar.stop().animate({
				top: contTopBarTopPos
			}, setAniSpeed);
		}
	};
	feUI.fixedLayoutMethod.init();
	// Select elements
	feUI.selectElMethod = {
		optionValue: {
			phone: [
				'02', '031', '032', '033', '041', '042', '043', '051', '052', '053',
				'054', '055', '061', '062', '063', '064', '070',
				'010', '011', '016', '017', '018', '019'
			],
			mobile: ['010', '011', '016', '017', '018', '019'],
			email: [
				'chollian.net', 'dreamwiz.com', 'empal.com', 'freechal.com', 'gmail.com',
				'hanafos.com', 'hananet.net', 'hanmail.net', 'hanmir.com', 'hitel.net',
				'hotmail.com', 'intizen.com', 'kebi.com', 'korea.com', 'kornet.net',
				'lycos.co.kr', 'msn.com', 'nate.com', 'naver.com', 'netian.com',
				'netsgo.com', 'orgio.net', 'paran.com', 'sayclub.com', 'shinbiro.com',
				'unitel.co.kr'
			]
		},
		init: function() {
			var $tgSelectEl;
			feUI.selectElMethod.selectEl = $body.find('select').not('.hideEl, .originType');
			$tgSelectEl = feUI.selectElMethod.selectEl.filter('[class*=selectType]');
			if ( !this.selectEl.length ) return false;
			if ( $tgSelectEl.length ) {
				$tgSelectEl.each(function() {
					var $this = $(this),
						tgOptionType, tgOptionVal, tgOptionSize, tgOptionTxt, tgOptionCode;
					if ( $this.hasClass('selectTypeP') ) tgOptionType = 'phone';
					if ( $this.hasClass('selectTypeM') ) tgOptionType = 'mobile';
					if ( $this.hasClass('selectTypeE') ) tgOptionType = 'email';
					tgOptionVal = feUI.selectElMethod.optionValue[tgOptionType],
					tgOptionSize = tgOptionVal.length;
					for ( var i = 0; i < tgOptionSize; i++ ) {
						tgOptionTxt = tgOptionVal[i];
						tgOptionCode = '<option value="' + tgOptionTxt + '">'
							+ tgOptionTxt + '</option>';
						$this.append(tgOptionCode);
					}
				});
			}
			feUI.selectElMethod.selectEl.feForm();
			feUI.selectElMethod._emailDomain();
			feUI.selectElMethod._dateSelect();
			feUI.selectElMethod._setSelected();
		},
		_emailDomain: function() {
			var $tgSelect = feUI.selectElMethod.selectEl.filter('.selectTypeE'),
				defaultOpVal = 'default';
			$tgSelect.on('change', function() {
				var $this = $(this),
					thisGroup = $this.data('group'),
					$selectedOp = $this.find('option:selected'),
					$domainInp = ( thisGroup )
						? $content.find('.inputTypeE[data-group="' + thisGroup + '"]')
						: $this.parent().prev(),
					selectedTxt = $selectedOp.text();
				( $selectedOp.val() === defaultOpVal )
					? $domainInp.removeAttr('readonly').val('').focus()
					: $domainInp.attr('readonly', 'readonly')
						.val(selectedTxt);
			});
		},
		_dateSelect: function() {
			var $ySelect = feUI.selectElMethod.selectEl.filter('.dateYY'),
				$mSelect = feUI.selectElMethod.selectEl.filter('.dateMM'),
				$dSelect = feUI.selectElMethod.selectEl.filter('.dateDD'),
				$ySelectS = $ySelect.filter('.startYY'),
				$ySelectE = $ySelect.filter('.endYY'),
				$mSelectS = $mSelect.filter('.startMM'),
				$mSelectE = $mSelect.filter('.endMM'),
				$dSelectS = $dSelect.filter('.startDD'),
				$dSelectE = $dSelect.filter('.endDD'),
				currentYear = new Date().getFullYear(),
				yearOp, monthOp, dayOp, yearMin, monthMin, dayMin,
				sYY, sMM, sDD, eYY, eMM, eDD;
			if ( arguments.length === 0 ) {
				setYear();
				setMonth();
				setDay();
			}
			$ySelect.add($mSelect).add($dSelect).on('change', function() {
				var $this = $(this),
					$thisWrapSib = $this.closest('.feFoSelect').siblings('.feFoSelect'),
					$target;
				if ( $this.is($ySelectS) ) {
					$target = $thisWrapSib.find($ySelectE),
					sYY = $this.val();
					setYear($target, sYY);
				} else if ( $this.is($mSelectS) ) {
					$target = $thisWrapSib.find($mSelectE),
					sMM = $this.val();
					compare('month', $target);
				} else if ( $this.is($dSelectS) ) {
					$target = $thisWrapSib.find($dSelectE),
					sDD = $this.val();
					compare('day', $target);
				} else if ( $this.is($ySelectE) ) {
					$target = $thisWrapSib.find($mSelectE),
					eYY = $this.val();
					compare('month', $target);
				} else if ( $this.is($mSelectE) ) {
					$target = $thisWrapSib.find($dSelectE),
					eMM = $this.val();
					compare('day', $target);
				} else if ( $this.is($dSelectE) ) {
					eDD = $this.val();
				}
			});
			function compare(type, $target) {
				if ( type === 'month' ) {
					if ( sYY === eYY ) {
						setMonth($target, sMM);
					} else if ( $target.find('option').length < 12 ) {
						setMonth($target, 1);
					}
				} else if ( type === 'day' ) {
					if ( sYY === eYY && sMM === eMM ) {
						setDay($target, sDD);
					} else if ( $target.find('option').length < 31 ) {
						setDay($target, 1);
					}
				} else {
					return false;
				}
			}
			function setYear($target, yearVal) {
				var maxYear = ( $body.find('h1:first').text().indexOf('梨꾩슜') === -1 )
					? currentYear : currentYear + 5;
				if ( arguments.length !== 0 ) {
					$target.find('option:not(:first-child)').remove();
					$ySelect = $target,
					yearMin = yearVal;
				} else {
					$ySelect = $ySelect,
					yearMin = 1910;
				}
				for ( var i = maxYear; i >= yearMin; i-- ) {
					yearOp = '<option value="' + i + '">' + i + '</option>';
					$ySelect.append(yearOp);
				}
				if ( arguments.length !== 0 ) {
					$target.trigger('feReset');
				}
			}
			function setMonth($target, monthVal) {
				if ( arguments.length !== 0 ) {
					$target.find('option:not(:first-child)').remove();
					$mSelect = $target;
					monthMin = parseInt(monthVal);
				} else {
					$mSelect = $mSelect,
					monthMin = 1;
				}
				for ( var i = monthMin; i <= 12; i++ ) {
					var monthTxt = ( i < 10 ) ? '0' + i : i;
					monthOp = '<option value="' + monthTxt + '">' + monthTxt + '</option>';
					$mSelect.append(monthOp);
				}
				if ( arguments.length !== 0 ) {
					$target.trigger('feReset');
				}
			}
			function setDay($target, dayVal) {
				if ( arguments.length !== 0 ) {
					$target.find('option:not(:first-child)').remove();
					$dSelect = $target;
					dayMin = parseInt(dayVal);
				} else {
					$dSelect = $dSelect,
					dayMin = 1;
				}
				for ( var i = dayMin; i <= 31; i++ ) {
					var dayTxt = ( i < 10 ) ? '0' + i : i;
					dayOp = '<option value="' + dayTxt + '">' + dayTxt + '</option>';
					$dSelect.append(dayOp);
				}
				if ( arguments.length !== 0 ) {
					$target.trigger('feReset');
				}
			}
		},
		_setSelected: function() {
			var $tgSelect = feUI.selectElMethod.selectEl.filter('[data-selected]');
			if ( !$tgSelect.length ) return false;
			$tgSelect.each(function() {
				var $this = $(this),
					selectedVal = $this.data('selected');
				$this.find('[value="' + selectedVal + '"]')
					.prop('selected', true).trigger('feChange');
			});
		}
	};
	feUI.selectElMethod.init();
	// Modal
	feUI.modalMethod = {
		tgEl: {
			modalWrapClass: 'modal',
			lockScrollClass: 'LS',
			dataClass: 'modal',
			dataURL: 'modal-url',
			dataOpen: 'modal-open',
			dataLoad: 'modal-load',
			dataClose: 'modal-close',
			openBtn: '.modalJs',
			closeBtn: '.btnClose, .closeBtn',
			aniSpeed: 200,
			$modalLoadWrap: '',
			$tgBtn: '',
			$tgLayer: ''
		},
		init: function() {
			var tgEl = feUI.modalMethod.tgEl;
			$wrap.off('.feUImodal').on('click.feUImodal', tgEl.openBtn, function(e) {
				tgEl.$tgBtn = $(this).addClass(activeClass);
				e.preventDefault();
				if ( tgEl.$tgBtn.data(tgEl.dataClass) ) {
					tgEl.$tgLayer = $('.' + tgEl.modalWrapClass)
						.filter('.' + tgEl.$tgBtn.data(tgEl.dataClass));
					feUI.modalMethod.viewLayer(0);
				} else if ( tgEl.$tgBtn.data(tgEl.dataURL) ) {
					feUI.modalMethod.loadLayer(0);
				} else {
					return false;
				}
			});
		},
		loadLayer: function(modalFileURL, openFunc, loadFunc, closeFunc) {
			var tgEl = feUI.modalMethod.tgEl,
				modalURL = ( modalFileURL === 0 )
					? tgEl.$tgBtn.data(tgEl.dataURL)
					: modalFileURL,
				modalClass = ( modalFileURL === 0 ) ? 1 : 2,
				modalLoadWrapIdx = $wrap.find('.modalLoadWrap').length + 1;
			$wrap.append('<div class="modalLoadWrap" data-modal-idx="' + modalLoadWrapIdx + '" />');
			tgEl.$modalLoadWrap = $wrap.find('.modalLoadWrap')
				.filter('[data-modal-idx="' + modalLoadWrapIdx + '"]');
			tgEl.$modalLoadWrap.load(modalURL, function(responseText, textStatus) {
				if ( textStatus === 'error' ) return false;
				tgEl.$tgLayer = tgEl.$modalLoadWrap.find('.' + tgEl.modalWrapClass);
				// View
				feUI.modalMethod.viewLayer(modalClass, openFunc, loadFunc, closeFunc);
				feUI.datepickerMethod.init();
				feUI.autoCompleteMethod.init();
				feUI.addFieldMethod.init();
				feUI.countTxtMethod.init();
				feUI.onlyNumInp();
				feUI.optChangeSel();
				feUI.schModalList();
				feUI.setTabEl();
				if ( !$('.main .videoWrap.feSlide').length ) {
					feUI.setSlideEl();
				}
			});
		},
		viewLayer: function(modalClass, openFunc, loadFunc, closeFunc) {
			// modalClass(0: button, in code/1: button, load file/function, load file)
			var tgEl = feUI.modalMethod.tgEl,
				tgLayerWidthF, openCallback, loadCallback;
			tgEl.scrollTopPos = scrollTopPos,
			tgEl.$tgLayer = ( modalClass !== 0 && modalClass !== 1 && modalClass !== 2 )
				? $('.' + tgEl.modalWrapClass).filter('.' + modalClass) : tgEl.$tgLayer;
			tgLayerWidthF = tgEl.$tgLayer.outerWidth();
			// KRC
			tgEl.krcModal = ( tgEl.$tgLayer.is('[class*="modal-depth"]') ) ? true : false,
			tgEl.$krcContInner = $content.find('.contInner').css('overflow', 'hidden');
			// Callback
			if ( modalClass === 0 || modalClass === 1 ) {
				if ( tgEl.$tgBtn.data(tgEl.dataOpen) )
					openCallback = feUI.stringToFunc(tgEl.$tgBtn.data(tgEl.dataOpen));
				if ( tgEl.$tgBtn.data(tgEl.dataLoad) )
					loadCallback = feUI.stringToFunc(tgEl.$tgBtn.data(tgEl.dataLoad));
				if ( tgEl.$tgBtn.data(tgEl.dataClose) )
					tgEl.$tgLayer.attr('data-' + tgEl.dataClose, tgEl.$tgBtn.data(tgEl.dataClose));
			} else {
				if ( openFunc ) openCallback = feUI.stringToFunc(openFunc);
				if ( loadFunc ) loadCallback = feUI.stringToFunc(loadFunc);
				if ( closeFunc ) tgEl.$tgLayer.attr('data-' + tgEl.dataClose, closeFunc);
			}
			if ( openCallback ) openCallback();
			// Position
			if ( tgEl.krcModal ) { // KRC
				tgEl.$krcContInner.append(tgEl.$modalLoadWrap);
			} else if ( !isMobView ) {
				( tgEl.$modalLoadWrap )
					? $dimmedLayer.before(tgEl.$modalLoadWrap)
					: $dimmedLayer.before(tgEl.$tgLayer);
			} else {
				( tgEl.$modalLoadWrap )
					? $wrap.append(tgEl.$modalLoadWrap)
					: $wrap.append(tgEl.$tgLayer);
			}
			// Dimmed
			if ( !tgEl.$tgLayer.hasClass('modalDimNone') && !tgEl.krcModal )
				$dimmedLayer.addClass('topIdxType').off().fadeIn(tgEl.aniSpeed);
			$wrap.find('.' + tgEl.modalWrapClass).filter(':visible')
				.not(tgEl.$tgLayer).not('[class*=modal-alert]')
					.css('zIndex', parseInt($dimmedLayer.css('zIndex')));
			// Center
			if ( !isMobView && !tgEl.krcModal ) tgEl.$tgLayer.css('margin-left', -tgLayerWidthF/2);
			$window.scrollTop(0);
			if ( !tgEl.krcModal ) {
				( !tgEl.$tgLayer.is(':visible') )
					? tgEl.$tgLayer.off().fadeIn(tgEl.aniSpeed, closeBtn)
					: tgEl.$tgLayer.off().hide()
						.css('zIndex', parseInt($dimmedLayer.css('zIndex')) + 10)
							.fadeIn(tgEl.aniSpeed, closeBtn);
			} else {
				var topPos = parseInt(tgEl.$tgLayer.css('top'));
				tgEl.$krcContInner.animate({
					'height': tgEl.$tgLayer.height() + topPos
				}, tgEl.aniSpeed);
				tgEl.$tgLayer.off().fadeIn(tgEl.aniSpeed, closeBtn)
					.attr('data-modal-origin', tgEl.$krcContInner.height());
			}
			function closeBtn() {
				// Close button
				$('.' + tgEl.modalWrapClass)
					.off('.feUImodal').on('click.feUImodal', tgEl.closeBtn, function(e) {
						var $this = $(this);
						tgEl.$tgLayer = $this.closest('.' + tgEl.modalWrapClass),
						tgEl.$modalLoadWrap = ( $this.closest('.modalLoadWrap').length )
							? $this.closest('.modalLoadWrap') : '';
						e.preventDefault();
						feUI.modalMethod.closeLayer();
					});
				// From loadLayer
				if ( modalClass === 1 || modalClass === 2 ) feUI.defaultFuncSet();
				if ( loadCallback ) loadCallback();
				feUI.focusRotation(tgEl.$tgBtn, tgEl.$tgLayer);
				feUI.modalMethod.lockScroll();
			}
		},
		closeLayer: function(closeFunc, closeAll) {
			var tgEl = feUI.modalMethod.tgEl,
				closeCallback;
			// Callback
			if ( closeFunc ) closeCallback = feUI.stringToFunc(closeFunc);
			if ( tgEl.$tgLayer.data(tgEl.dataClose) )
				closeCallback = feUI.stringToFunc(tgEl.$tgLayer.data(tgEl.dataClose));
			// Dimmed
			if ( $wrap.find('.' + tgEl.modalWrapClass).not('[class*="modal-depth"]')
					.filter(':visible').length < 2
				|| closeAll === 1 ) {
				$dimmedLayer.off().fadeOut(tgEl.aniSpeed, function() {
					$dimmedLayer.removeClass('topIdxType');
				});
			}
			// Layer
			if ( !tgEl.krcModal ) {
				if ( $wrap.find('.' + tgEl.modalWrapClass).not(tgEl.$tgLayer)
						.filter(':visible').length ) {
					$wrap.find('.' + tgEl.modalWrapClass).not(tgEl.$tgLayer)
						.filter(':visible:last')
						.css('zIndex', parseInt($dimmedLayer.css('zIndex')) + 10);
				}
				if ( closeAll === 1 ) {
					tgEl.$tgLayer = $wrap.find('.' + tgEl.modalWrapClass).filter(':visible');
					tgEl.$modalLoadWrap = $wrap.find('.modalLoadWrap:visible');
				}
			} else {
				// Fade
				if ( tgEl.$tgLayer.is('.modal-depth01') ) {
					tgEl.$tgLayer = $wrap.find('[class*="modal-depth"]').filter(':visible');
					tgEl.$modalLoadWrap = $wrap.find('.modalLoadWrap:visible');
				}
				tgEl.$krcContInner.animate({
					'height': tgEl.$tgLayer.data('modal-origin')
				}, tgEl.aniSpeed, function() {
					$(this).removeAttr('style');
				});
			}
			tgEl.$tgLayer.off().fadeOut(tgEl.aniSpeed, function() {
				if ( tgEl.$modalLoadWrap ) tgEl.$modalLoadWrap.remove();
				if ( closeCallback ) closeCallback();
				if ( $html.hasClass(tgEl.lockScrollClass) ) feUI.modalMethod.lockScroll(0);
				$window.scrollTop(tgEl.scrollTopPos);
				$wrap.find(tgEl.openBtn).filter('.active:visible:last').focus()
					.removeClass(activeClass);
			});
		},
		lockScroll: function(type) {
			var tgEl = feUI.modalMethod.tgEl,
				modalHeight;
			if ( tgEl.$tgLayer ) modalHeight = tgEl.$tgLayer.height();
			if ( type === 0 || isMobView ) {
				$html.removeClass(tgEl.lockScrollClass);
				return false;
			}
			if ( !tgEl.$tgLayer || !tgEl.$tgLayer.filter(':visible').length ) return false;
			$window.scrollTop(0);
			( winHeight >= modalHeight + (tgEl.$tgLayer.offset().top * 2) )
				? $html.addClass(tgEl.lockScrollClass)
				: $html.removeClass(tgEl.lockScrollClass);
		}
	};
	feUI.modalMethod.init();
	// Toggle Form
	feUI.toggleFormMethod = {
		tgEl: {
			hideClass: 'tgHideEl' // IE7
		},
		init: function() {
			var tgEl = feUI.toggleFormMethod.tgEl;
			tgEl.$toggleTrigger = $wrap.find(':checkbox[data-tg-trigger], \
				:radio[data-tg-trigger], select:has([data-tg-trigger])'),
			tgEl.$toggleWrap = $wrap.find('[data-tg-wrap]').attr({
				'role': 'region',
				'aria-expanded': false
			}),
			tgEl.$uncheckWrap = $wrap.find('[data-tg-uncheck]')
				.not('[data-tg-trigger]'),
			tgEl.$toggleGroup = $wrap.find('[data-tg-group]')
				.not('[data-tg-trigger]');
			if ( !tgEl.$toggleTrigger.length ) return false;
			tgEl.$toggleTrigger.on('change check', function() {
				var $this = ( $(this).prop('tagName') === 'INPUT' )
						? $(this) : $(this).find(':checked');
				feUI.toggleFormMethod._toggle($this);
			}).trigger('check');
		},
		_toggle: function($this) {
			var tgEl = feUI.toggleFormMethod.tgEl,
				tgTriggerVal = $this.attr('data-tg-trigger'),
				tgGroupVal = $this.attr('data-tg-group'),
				tgUncheckVal = $this.attr('data-tg-uncheck'),
				$tgWrap = tgEl.$toggleWrap
					.filter('[data-tg-wrap=' + tgTriggerVal + ']'),
				$tgUncheckWrap = tgEl.$uncheckWrap
					.filter('[data-tg-uncheck=' + tgUncheckVal + ']'),
				$tgGroup = tgEl.$toggleGroup
					.filter('[data-tg-group=' + tgGroupVal + ']'),
				checkedVal = $this.is(':checked');
			if ( checkedVal ) {
				if ( tgGroupVal ) $tgGroup.hide().addClass(tgEl.hideClass)
					.attr('aria-expanded', false);
				$tgWrap.show().removeClass(tgEl.hideClass)
					.attr('aria-expanded', true);
				$tgUncheckWrap.hide().addClass(tgEl.hideClass)
					.attr('aria-expanded', false);
			} else {
				$tgWrap.hide().addClass(tgEl.hideClass)
					.attr('aria-expanded', false);
				$tgUncheckWrap.show().removeClass(tgEl.hideClass)
					.attr('aria-expanded', true);
			}
		}
	};
	feUI.toggleFormMethod.init();
	feUI.replaceImageGuide();
	// jQuery UI Datepicker
	feUI.datepickerMethod = {
		tgEl: {
			icoURL: '../../asset/img/common/ico_calendar.png',
			icoTxt: '�щ젰 蹂닿린'
		},
		init: function() {
			var tgEl = feUI.datepickerMethod.tgEl,
				winLocation = window.location.href,
				cookieNameLocation = 'dpvl',
				cookieNameBefore = 'dpvb',
				cookieNameAfter = 'dpva',
				$submitBtn = $wrap.find(':submit, .btnType03');
			tgEl.$dpInp = $wrap.find('.input-date'),
			tgEl.$dpInpFrom = tgEl.$dpInp.filter('.input-dateFrom'),
			tgEl.$dpInpTo = tgEl.$dpInp.filter('.input-dateTo'),
			// WDOC
			tgEl.$dateWrap = tgEl.$dpInp.closest('.datePicker'),
			tgEl.$dpInpToday = tgEl.$dpInp.filter('.dpInpToday'),
			// Set date button
			tgEl.$setBtn = $wrap.find('[data-setdate]');
			if ( !tgEl.$dpInp.length
				&& !$wrap.find('.layerDetSearch').length ) return false;
			tgEl.$dpInp.not('.minDate').datepicker({
				showOn: 'button',
				buttonImage: tgEl.icoURL,
				buttonText: tgEl.icoTxt,
				buttonImageOnly: true,
				changeYear: true
			}).end().filter('.minDate').datepicker({
				// RECRUIT applyModal
				showOn: 'button',
				buttonImage: tgEl.icoURL,
				buttonText: tgEl.icoTxt,
				buttonImageOnly: true,
				changeYear: true,
				minDate: '-2y',
				maxDate: '0'
			});
			feUI.datepickerScope();
			if ( tgEl.$dpInpFrom.length ) feUI.datepickerMethod._setMinMax();
			if ( tgEl.$dpInpToday.length ) {
				tgEl.$dpInpToday.each(function() {
					var $this = $(this),
						$tgDpInpBefore = $this.closest(tgEl.$dateWrap)
							.siblings(tgEl.$dateWrap).find(tgEl.$dpInp);
					$this.datepicker('setDate', '0');
					$tgDpInpBefore.datepicker('setDate', '-1y');
					$this.add($tgDpInpBefore)
						.datepicker('option', 'minDate', '-5y')
						.datepicker('option', 'maxDate', '0');
				});
				// Reset date
				if ( tgEl.$dpInpToday.length === 1 ) {
					var $tgDpInpBefore = tgEl.$dpInpToday.closest(tgEl.$dateWrap)
						.siblings(tgEl.$dateWrap).find(tgEl.$dpInp);
					$submitBtn.on('click', function() {
						feUI.createCookie(cookieNameLocation, winLocation, 1);
						feUI.createCookie(cookieNameAfter, tgEl.$dpInpToday.val(), 1);
						feUI.createCookie(cookieNameBefore, $tgDpInpBefore.val(), 1);
					});
					if ( feUI.getCookie(cookieNameLocation) !== null
						&& feUI.getCookie(cookieNameBefore) !== null
						&& feUI.getCookie(cookieNameAfter) !== null ) {
						if ( feUI.getCookie(cookieNameLocation) !== winLocation ) return false;
						tgEl.$dpInpToday.datepicker('setDate', feUI.getCookie(cookieNameAfter));
						$tgDpInpBefore.datepicker('setDate', feUI.getCookie(cookieNameBefore));
						feUI.deleteCookie(cookieNameLocation);
						feUI.deleteCookie(cookieNameBefore);
						feUI.deleteCookie(cookieNameAfter);
					}
				}
			}
			if ( tgEl.$setBtn.length ) feUI.datepickerMethod._setDateBtn();
		},
		_setMinMax: function() {
			var tgEl = feUI.datepickerMethod.tgEl;
			tgEl.$dpInpFrom.on('change', function() {
				var $this = $(this),
					$tgDpInpTo = $this.closest(tgEl.$dateWrap)
						.siblings(tgEl.$dateWrap).find(tgEl.$dpInpTo);
				$tgDpInpTo.datepicker('option', 'minDate', $this.val());
			});
			tgEl.$dpInpTo.on('change', function() {
				var $this = $(this),
					$tgDpInpFrom = $this.closest(tgEl.$dateWrap)
						.siblings(tgEl.$dateWrap).find(tgEl.$dpInpFrom);
				$tgDpInpFrom.datepicker('option', 'maxDate', $this.val());
			});
		},
		_setDateBtn: function() {
			var tgEl = feUI.datepickerMethod.tgEl,
				calcUnit, setDateVal, $inpGroup;
			tgEl.$setBtn.filter(':radio').on('change', function(e) {
				setDate(e);
			}).end().not(':radio').on('click', function(e) {
				setDate(e);
			});
			function setDate(e) {
				var $this = $(e.target),
					dateVal = $this.data('setdate'),
					groupVal = $this.data('dpinp');
				calcUnit = dateVal.slice(0, 1),
				setDateVal = dateVal.split(calcUnit + '-')[1],
				$inpGroup = $wrap.find(':text[data-dpinp=' + groupVal +']');
				e.preventDefault();
				e.stopImmediatePropagation();
				( calcUnit === 'b' )
					? $inpGroup.first().datepicker('setDate', '-' + setDateVal).end()
						.last().datepicker("setDate", new Date())
					: $inpGroup.first().datepicker('setDate', new Date()).end()
						.last().datepicker('setDate', '+' + setDateVal).end();
			}
		}
	};
	feUI.datepickerMethod.init();
	// Gallery
	feUI.galleryImageMethod = {
		tgEl: {},
		init: function() {
			var tgEl = feUI.galleryImageMethod.tgEl;
			tgEl.$galleryWrap = $content.find('.thumBnrWrap'),
			tgEl.$galleryItem = tgEl.$galleryWrap.find('.feSlItem')
				.attr('role', 'button'),
			tgEl.$preViewWrap = $content.find('.gallerySlide')
				.prepend('<div class="slideMask" />'),
			tgEl.$galleryTxt = tgEl.$preViewWrap.find('.galleryTxt'),
			tgEl.$preViewMask = tgEl.$preViewWrap.find('.slideMask'),
			tgEl.$preViewBtn = tgEl.$preViewWrap.find('button'),
			tgEl.galleryItemSize = tgEl.$galleryItem.size(),
			tgEl.aniSpeed = 500,
			tgEl.currentIdx = 0,
			tgEl.$preViewImg, tgEl.currentDir;
			if ( !tgEl.$galleryWrap.length ) return false;
			feUI.galleryImageMethod._setDefault();
		},
		_setDefault: function() {
			var tgEl = feUI.galleryImageMethod.tgEl;
			tgEl.$galleryWrap.feSlide({
				visibleItem: 4,
				pagingBtn: false,
				aniSpeed: tgEl.aniSpeed
			});
			tgEl.$galleryItem.on('click', function(e) {
				var $this = $(this);
				tgEl.currentIdx = $(this).index();
				e.preventDefault();
				if ( $this.hasClass(activeClass) ) return false;
				feUI.galleryImageMethod._setPreView(1);
			}).each(function() {
				var $tgImg = $(this).find('img');
				tgEl.$preViewMask.append( $tgImg.clone() );
			});
			tgEl.$preViewBtn.on('click', function() {
				var $this = $(this);
				tgEl.currentDir = ( $this.hasClass('btnPrev') )
					? tgEl.currentDir = 'prev' : tgEl.currentDir = 'next';
				( tgEl.currentDir === 'prev' )
					? ( tgEl.currentIdx === 0 )
						? tgEl.currentIdx = tgEl.galleryItemSize - 1 : tgEl.currentIdx--
					: ( tgEl.currentIdx + 1 === tgEl.galleryItemSize )
						? tgEl.currentIdx = 0 : tgEl.currentIdx++;
				feUI.galleryImageMethod._setPreView(1);
			});
			tgEl.$preViewImg = tgEl.$preViewMask.find('img');
			feUI.galleryImageMethod._setPreView();
		},
		_setActive: function() {
			var tgEl = feUI.galleryImageMethod.tgEl;
			tgEl.$galleryItem.removeClass(activeClass)
				.eq(tgEl.currentIdx).addClass(activeClass);
		},
		_setPreView: function() {
			var tgEl = feUI.galleryImageMethod.tgEl;
			feUI.galleryImageMethod._setActive();
			( arguments.length === 0 )
				? tgEl.$preViewImg.eq(tgEl.currentIdx).show()
				: tgEl.$preViewImg
					.filter(':visible').fadeOut(tgEl.aniSpeed).end()
					.eq(tgEl.currentIdx).fadeIn(tgEl.aniSpeed);
			if ( tgEl.$galleryTxt.length )
				feUI.galleryImageMethod._setGalleryTxt(tgEl.$preViewImg.eq(tgEl.currentIdx));
		},
		_setGalleryTxt: function($tgImg) {
			var tgEl = feUI.galleryImageMethod.tgEl,
				tgImgTitle = ($tgImg.data('imgtitle')) ? $tgImg.data('imgtitle') : '',
				tgImgAlt = ($tgImg.prop('alt')) ? $tgImg.prop('alt') : '',
				txtCode = (tgImgTitle !== '')
					? '<strong>' + tgImgTitle + '</strong>' + '<span>' + tgImgAlt + '</span>'
					: '<span>' + tgImgAlt + '</span>';
			tgEl.$galleryTxt.html(txtCode);
			( !tgImgTitle && !tgImgAlt )
				? tgEl.$galleryTxt.hide() : tgEl.$galleryTxt.show();
		}
	};
	feUI.galleryImageMethod.init();
	// Count character
	feUI.countTxtMethod = {
		tgEl: {
			dataName: 'maxlength',
			alertTxt: '내용 입력 글자 수를 초과했습니다.'
		},
		init: function() {
			var tgEl = feUI.countTxtMethod.tgEl;
			tgEl.$textWrap = $wrap.find('textarea[data-maxlength]');
			if ( !tgEl.$textWrap.length ) return false;
			feUI.countTxtMethod._countCharacter(tgEl);
		},
		_getCharByte: function(string, maxLength, size, c, i) {
			if ( string === null || string.length === 0 ) return 0;
			for ( size = i = 0; i < string.length; i++ ) {
				c = string.charCodeAt(i);
				size += c >> 11 ? 3 : c >> 7 ? 2 : 1;
				if ( maxLength ) {
					if ( size === maxLength ) {
						i = i + 1;
						break;
					} else if ( size > maxLength ) {
						i = i;
						break;
					}
				}
			}
			return [size, string.substring(0, i)];
		},
		_setTxtCounter: function($txtCounter, stringLength) {
			stringLength = ( stringLength < 10 )
				? '00' + stringLength
				: ( stringLength < 100 ) ? '0' + stringLength : stringLength;
			$txtCounter.text(stringLength);
		},
		_countCharacter: function(tgEl) {
			tgEl.$textWrap.off('keyup').on('keyup', function() {
				var $this = $(this),
					$txtCounter = $this.siblings('.byte').find('em'),
					tgString = $this.val(),
					maxLength = $this.data(tgEl.dataName);
				if ( feUI.countTxtMethod._getCharByte(tgString)[0] > maxLength ) {
					//alert(tgEl.alertTxt);
					setTimeout(function() {
						$this.val(feUI.countTxtMethod._getCharByte(tgString, maxLength)[1]);
					});
				}
				setTimeout(function() {
					if ( $txtCounter.length )
						feUI.countTxtMethod._setTxtCounter($txtCounter, $this.val().length);
				});
			}).trigger('keyup');
		}
	};
	feUI.countTxtMethod.init();
	// Add field
	feUI.addFieldMethod = {
		tgEl: {},
		init: function() {
			var tgEl = feUI.addFieldMethod.tgEl;
			tgEl.$formField = $wrap.find('.addFormField[data-form-group]'),
			tgEl.$addBtn = $wrap.find('.addFormBtn[data-form-group]'),
			tgEl.$removeBtn = $wrap.find('.removeFormBtn');
			if ( arguments.length !== 0 ) return false;
			if ( !tgEl.$addBtn.length ) return false;
			feUI.addFieldMethod._addField();
		},
		_addField: function() {
			var tgEl = feUI.addFieldMethod.tgEl;
			tgEl.$addBtn.on('click check', function(e) {
				var $this = $(this),
					groupVal = $this.data('form-group'),
					groupValFilter = '[data-form-group="' + groupVal + '"]',
					cloneCode = feUI.saveHTMLTemplate(groupVal),
					$tgFormField = tgEl.$formField.filter(groupValFilter);
				e.preventDefault();
				if ( e.type === 'click' ) {
					$tgFormField.filter(':last').after(cloneCode);
					// Update var
					tgEl.$formField = $wrap.find('.addFormField[data-form-group]'),
					$tgFormField = tgEl.$formField.filter(groupValFilter),
					tgEl.$removeBtn = $wrap.find('.removeFormBtn');
					// Reset
					feUI.setFormEl();
					feUI.selectElMethod.init();
					feUI.datepickerMethod.init();
					$tgFormField.filter(':last')
						.find('select').trigger('feReset').end()
						.find(':checkbox').trigger('feReset').end()
						.find(':text').val('').end()
						.find('.input-date').next('.ui-datepicker-trigger').remove().end()
							.removeAttr('id').removeClass('hasDatepicker').datepicker({
							showOn: 'button',
							buttonImage: assetDir + '/img/common/ico_date.png',
							buttonText: '달력 보기',
							buttonImageOnly: true,
							changeYear: true
						});
				}
				$tgFormField.find(tgEl.$removeBtn).show().end()
					.filter(':first').find(tgEl.$removeBtn).hide();
				feUI.addFieldMethod._removeField();
				feUI.addFieldMethod._setIdx();
			}).trigger('check');
		},
		_removeField: function() {
			var tgEl = feUI.addFieldMethod.tgEl;
			tgEl.$removeBtn.off().on('click', function() {
				var $this = $(this),
					$tgFormField = $this.closest(tgEl.$formField);
				if ( confirm('삭제하시겠습니까?') ) {
					$tgFormField.remove();
					tgEl.$formField = $wrap.find('.addFormField[data-form-group]');
					feUI.addFieldMethod._setIdx();
				} else {
					return false;
				}
			});
		},
		_setIdx: function() {
			var tgEl = feUI.addFieldMethod.tgEl;
			tgEl.$formField.each(function() {
				var $this = $(this),
					$idxNum = $this.find('.idxNum'),
					groupVal = $this.data('form-group'),
					groupValFilter = '[data-form-group="' + groupVal + '"]',
					formIdx = tgEl.$formField.filter(groupValFilter).index($this) + 1,
					$tgAddBtn = tgEl.$addBtn.filter(groupValFilter),
					maxSize = ( $tgAddBtn.is('[data-form-max]') )
						? $tgAddBtn.data('form-max') : 500;
				$this.attr('data-form-idx', formIdx);
				// Title
				if ( $idxNum.length ) {
					( tgEl.$formField.filter(groupValFilter).length > 1 )
						? $idxNum.text(formIdx + '. ') : $idxNum.text('');
				}
				// Toggle add button
				( tgEl.$formField.filter(groupValFilter).length >= maxSize )
					? $tgAddBtn.hide() : $tgAddBtn.show();
				feUI.addFieldMethod._resetToggleForm($this, formIdx);
			});
		},
		_resetToggleForm: function($tgField, formIdx) {
			var $tgGroup = $tgField.find('[data-tg-group]'),
				$reLabel = $tgField.find('.reLabel');
			$tgGroup.each(function() {
				var $this = $(this),
					tgGroupVal = $this.data('tg-group'),
					tgWrapVal = $this.data('tg-wrap'),
					tgTriggerVal = $this.data('tg-trigger'),
					tgUncheckVal = $this.data('tg-uncheck');
				if ( tgGroupVal ) $this.attr('data-tg-group', tgGroupVal + 'Idx' + formIdx);
				if ( tgWrapVal ) $this.attr('data-tg-wrap', tgWrapVal + 'Idx' + formIdx);
				if ( tgTriggerVal ) $this.attr('data-tg-trigger', tgTriggerVal + 'Idx' + formIdx);
				if ( tgUncheckVal ) $this.attr('data-tg-uncheck', tgUncheckVal + 'Idx' + formIdx);
			});
			$reLabel.each(function() {
				var $this = $(this),
					tgForVal = $this.prev('label').attr('for');
				$this.attr('for', tgForVal);
			});
		}
	};
	feUI.addFieldMethod.init();
	// Browser update layer
	feUI.bwUpdateLayerMethod = {
		tgEl: {},
		init: function() {
			var tgEl = feUI.bwUpdateLayerMethod.tgEl,
				checkIE = feUI.setOldIE();
			tgEl.layerURL = assetDir + '/layer/layerBrow.html',
			tgEl.cookieName = 'bwlayer',
			tgEl.closeCallback = 'feUI.bwUpdateLayerMethod.checkClose';
			if ( feUI.getCookie(tgEl.cookieName) === '1'
				|| !$html.is('[lang="ko"]') || !checkIE.isIE || ieVer > 8 ) return false;
			if ( !$html.hasClass('mainContent')
				&& !$content.hasClass('mainIntroContent') ) return false;
			feUI.modalMethod.loadLayer(tgEl.layerURL, '', '', tgEl.closeCallback);
		},
		checkClose: function() {
			var tgEl = feUI.bwUpdateLayerMethod.tgEl;
			feUI.createCookie(tgEl.cookieName, 1, 1);
		}
	};
	feUI.bwUpdateLayerMethod.init();
	// galleryMethod
	feUI.galleryMethod = {
		init: function() {
			var $galleryList = $wrap.find('.galleryList').add('.gallery-view');
			if ( $galleryList.length ) feUI.galleryMethod._galleryNum();
		},
		_galleryNum: function(){
			var $galleryList = $wrap.find('.galleryList').add('.gallery-view'),
				$galleryAnchor = $galleryList.find('a');
			$galleryAnchor.off().on('click', function(){
				var galleryNum = $(this).data('galleryNum'),
					galleryName = $(this).find('.name').text();
				feUI.galleryMethod._slideNum(galleryNum);
				feUI.galleryMethod._slideTitle(galleryName);
			});
		},
		_slideNum: function(num){
			setTimeout(function() {
				var $modal = $wrap.find('.modal'),
					$galleryView = $modal.find('.gallerySlide'),
					$galleryViewPage = $galleryView.find('.feSlPaging');
				$galleryViewPage.find('li:eq(' + (num - 1) + ') a').trigger('feClick');
			}, 100);
		},
		_slideTitle: function(name){
			setTimeout(function(){
				var $modal = $wrap.find('.modal'),
					$modalTitle = $modal.find('.galleryTitle');
					$modalTitle.text(name);
			}, 100);
		}
	};
	feUI.galleryMethod.init();
	// autoComplete
	feUI.autoCompleteMethod = {
		init: function() {
			var $formAuto = $wrap.find('.formAuto'),
				$autoInp = $formAuto.find('.input'),
				$school = $formAuto.find('.autoSchool'),
				$docTreat = $formAuto.find('.docTreatInfo');
			$autoInp.on('keyup', function(){
				var $this = $(this);
				if( !$this.val() == '' ) {
					$this.parents('.formAuto').find('.autoContent').slideDown(300);
				} else {
					$this.parents('.formAuto').find('.autoContent').slideUp(300);
				}
			});
			if ( $docTreat.length ) feUI.autoCompleteMethod._instructor();
			if ( $school.length ) feUI.autoCompleteMethod._school();
		},
		_instructor: function(){
			var $formAuto = $wrap.find('.formAuto'),
				$autoContent = $formAuto.find('.autoContent'),
				$docTreat = $formAuto.find('.docTreatInfo');
				$docTreat.on('click', function(){
					var $autoInp = $(this).parents('.formAuto').find('.input'),
						userValue = $(this).find('.docDesc strong').text();
						$autoInp.val(userValue);
						$autoContent.slideUp(300);
				});
				$document.off().on('click', function(e){
					if ( !$(e.target).is('.autoContent') ) {
						$autoContent.slideUp();
					}
				});
		},
		_school: function(){
			var $formAuto = $wrap.find('.formAuto'),
				$autoInp = $formAuto.find('.input'),
				$autoContent = $formAuto.find('.autoContent'),
				$school = $formAuto.find('.autoSchool'),
				$schoolList = $school.find('.schoolList li a');
			$schoolList.on('click', function(e){
				e.preventDefault();
				var $autoInp = $(this).parents('.formAuto').find('.input'),
					schoolVal = $(this).text();
					$autoInp.val(schoolVal);
					$autoContent.slideUp();
			});
			$document.off().on('click', function(e){
				if ( !$(e.target).is('.autoContent') ) {
					$autoContent.slideUp();
				}
			});
		}
	};
	feUI.autoCompleteMethod.init();
	//main treat&docter auto search
	feUI.mainAutoComplete = {
		init: function() {
			var $mainTreat = $wrap.find('.mainTreatSrh'),
				$formAuto = $wrap.find('.mainTreatSrh .form'),
				$autoLayer = $formAuto.find('.autoComplete');
			if ( !$mainTreat.length ) return false;
			$autoLayer.hide();
			feUI.mainAutoComplete._layerOpen();
			feUI.mainAutoComplete._layerClose();
		},
		_layerOpen: function() {
			var $formAuto = $wrap.find('.mainTreatSrh .form'),
				$formSearch = $formAuto.find('.search input'),
				$autoLayer = $formAuto.find('.autoComplete');
			$formSearch.off().on('keyup', function(e){
				if ( !$formSearch.val() ) {
					feUI.mainAutoComplete._layerReset();
					$autoLayer.slideUp(300);
					return false;
				}
				if ( $formSearch.val().length > 0 ) {
					$html.addClass('mainTreatLayer');
					$formAuto.css('z-index', '205');
					$dimmedLayer.addClass('topIdxType').off().fadeIn(aniSpeed);
					$autoLayer.slideDown(300);
				}
			});
		},
		_layerClose: function() {
			var $formAuto = $wrap.find('.mainTreatSrh .form'),
				$autoLayer = $formAuto.find('.autoComplete');
			$document.off().on('click', '.mainTreatLayer .dimmedLayer', function(){
				feUI.mainAutoComplete._layerReset();
				$autoLayer.slideUp(300);
			});
		},
		_layerOff: function() {
			var $formAuto = $wrap.find('.mainTreatSrh .form'),
				$autoLayer = $formAuto.find('.autoComplete');
			feUI.mainAutoComplete._layerReset();
			$autoLayer.slideUp(300);
		},
		_layerReset: function() {
			var $formAuto = $wrap.find('.mainTreatSrh .form');
			$html.removeClass('mainTreatLayer');
			$formAuto.removeAttr('style');
			$dimmedLayer.addClass('topIdxType').off().fadeOut(aniSpeed);
		}
	};
	feUI.mainAutoComplete.init();
	// Window Event
	$window.on({
		'resize': function() {
			if ( winWidth !== $window.width() ) {
				winWidth = $window.width(),
				wideView = ( winWidth > wrapMinWidth ) ? true : false;
			}
			if ( winHeight !== $window.height() ) {
				winHeight = $window.height();
			}
			feUI.fixedLayoutMethod.init();
			feUI.modalMethod.lockScroll();
		},
		'scroll': function() {
			scrollTopPos = $window.scrollTop();
			feUI.fixedLayoutMethod.init();
		}
	});
})(feUI, jQuery, window, document);