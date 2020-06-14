document.addEventListener("turbolinks:load", function() {
  $(function() {

    {// 共通
      console.log($("body nav button"));
      $("body nav button").click(function(){
        $("body nav div li").toggleClass('sm');
        console.log($("body nav div li"));
      });


    }

    {//index
      const TIME = 500;

      $("#index main dt").hover(function(){
        $(this).next().stop().fadeIn(TIME);
      },function(){
        $(this).next().stop().fadeOut(TIME);
      });

      $(".q-search").click(function() {
          let input = $("#word").val();

          $.ajax({
            type:'GET', // リクエストのタイプはGETです
            url: '/', // URLは"/meals"を指定します
            data: {word: input}, // コントローラへフォームの値を送信します
            dataType: 'json' // データの型はjsonで指定します
          })
          .done(function(data){
            // 前の検索結果が残っていれば削除
            if ($("#index main div > div > article").length){
               $("#index main div > div").empty()
            }
            // articleを挿入して、articleの中にliで並べていく

            data.forEach(function(search_q,i){
              $("#index main div > div").append("<article></article>");
              $(`#index main div > div > article:nth-child(${i + 1})`).append(`<dl><dt>${search_q.title}</dt></dl>`);
            });
          })
          .fail(function(){
            alert('通信に失敗しました');
          });
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
    }

  });
});

