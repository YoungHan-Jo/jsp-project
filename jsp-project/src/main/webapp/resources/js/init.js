//when document loaded
$(document).ready(function() {
	// sidenav init 컴포넌트 초기화
	$('.sidenav').sidenav();

	//collapsible init 컴포넌트 초기화
	$('.collapsible').collapsible();
	
	// select init 셀렉트 초기화
    $('select').formSelect();
    
    // autocomplete init 자동완성
    $('input.autocomplete').autocomplete({
      data: {
        "Apple": null,
        "Microsoft": null,
        "Google": 'https://placehold.it/250x250'
      },
    });
  
});

