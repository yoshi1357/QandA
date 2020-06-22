document.addEventListener("turbolinks:load", function() {
  $(function() {

    {// 共通
      $("#hamb").click(function(){
        $("body nav div li").toggleClass('sm');
      });


    }

    {//index
      const TIME = 500;

      // マウスオーバーで質問内容を表示
      $("#index main dt").hover(function(){
        $(this).next().stop().fadeIn(TIME);
      },function(){
        $(this).next().stop().fadeOut(TIME);
      });

      // $(".q-search").click(function() {
      //     let input = $("#word").val();

      //     $.ajax({
      //       type:'GET', // リクエストのタイプはGETです
      //       url: '/', // URLは"/meals"を指定します
      //       data: {word: input}, // コントローラへフォームの値を送信します
      //       dataType: 'json' // データの型はjsonで指定します
      //     })
      //     .done(function(data){
      //       //h2を書き換える
      //       $("main h2").html(`検索結果は${data.length}件です`)
      //       // 前の検索結果が残っていれば削除
      //       if ($("#wrapper-result > article").length){
      //         $("#wrapper-result").empty()
      //       }
      //       // articleを挿入して、articleの中にliで並べていく

      //       data.forEach(function(search_q,i){
      //         $("#wrapper-result").append('<article class="col-md-6"></article>');
      //         //受け取ったidを使ってリンクを生成
      //         $(`#wrapper-result > article:nth-child(${i + 1})`).append(`<dl><hr><dt><a href="/questions/${search_q.id}">${search_q.title}</a></dt><hr></dl>`);
      //       });
      //     })
      //     .fail(function(){
      //       alert('通信に失敗しました');
      //     });
      // });

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

