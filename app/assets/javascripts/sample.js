document.addEventListener("turbolinks:load", function() {
  $(function() {

    {// 共通


    }

    {//index
      const time = 500;

      $("#index main dt").hover(function(){
        $(this).next().stop().fadeIn(time);
      },function(){
        $(this).next().stop().fadeOut(time);
      });

    }


    {// show
      $("#show button").click(function(){
        $(this).parent().next().toggleClass('disable')

        if ($(this).html() === "この質問に回答する！") {
          $(this).html("回答フォームを折りたたむ");
        }else{
          $(this).html("この質問に回答する！");
        }
        console.log($(this).html());
      });
    }

  });
});

