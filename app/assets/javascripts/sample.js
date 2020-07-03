document.addEventListener("turbolinks:load", function() {
  $(function() {

    {// 共通
      // navbarを上部に固定する
      let navPos = $("#nav").offset().top;

      $(window).scroll(function(){
        if ($(window).scrollTop() > navPos) {
          $("#nav").css("position", "fixed");
        } else {
          $("#nav").css("position", "static");
        }
      });

      // a[href="#~"]（ページ内リンク）をスムーズにスクロール(サイドバーのタブは除く)
      $('a[href^="#"]').not('a[href^="#bar"]').click(function() {
          let target = $($(this).attr('href')).offset().top;
          $("html,body").animate({scrollTop: target}, 500);

          return false;
      });

    }

    {//index

      // マウスオーバーで質問内容を表示
      $("#index main dt,#show-user main dt").hover(function(){
        $(this).next().removeClass('d-none');
      },function(){
        $(this).next().addClass('d-none');
      });

    }


    {// show
      $("#show button").click(function(){
        $(this).next().toggleClass('disable')

        if ($(this).html() === "この質問に回答する！") {
          $(this).html("回答フォームを折りたたむ");
        }else{
          $(this).html("この質問に回答する！");
        }
        console.log($(this).html());
      });

      // 解答者が質問者が同じなら、プロフィールを左へ
      let answers_user_id = gon.answers_user_id;
      let question_user_id = gon.question_user_id;


      if (answers_user_id.length !== 0){
        answers_user_id.forEach (function (answer_user_id, i){
          if (answer_user_id === question_user_id) {
            console.log( $("#show profile").eq(i));

            $("#show profile.flex-row-reverse").eq(i).children('thumbnail').children('img').addClass("mr-4");
            $("#show profile.flex-row-reverse").eq(i).children('thumbnail').children('img').removeClass("ml-4");
            $("#show profile.flex-row-reverse").eq(i).removeClass("flex-row-reverse");
          }
        });
      }
    }
  });
});

