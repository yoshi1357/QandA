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

      // sort_linkへのボタン化
      $("#index block > a").each(function(){
        if (!$(this).hasClass("btn btn-primary")) {
          $(this).addClass("btn btn-primary");
        }
      });

      // $(".question-title-abr").mouseenter(function(){
      //   let qid = $(this).attr('data_qid')

      //   $.ajax({
      //   type: "GET",
      //   url: "/",
      //   cache: false,
      //   dataType: "script",
      //   //必要なステータスを送るremote:trueを忘れずに
      //   // この値をコントローラー側でparams[:qid]で受け取れる
      //   data: { qid: qid, remote: true }
      //   });

      // });
      // タイトルの省略の解除をホバーで行う
      $(".question-title-abr").each(function(i, ele){
        let a_str = $(ele).children().text();
        let a_str_abr = `${$(ele).children().text().slice(0,19)}…`;

        if (a_str.length >= 20) {
          $(ele).children().text(a_str_abr);

          $(ele).mouseenter(function(){
            $(this).children().text(a_str);
          });

          $(ele).mouseleave(function(){
            $(this).children().text(a_str_abr);
          });
        }


      });




    }


    {// show
      // $("#show button").click(function(){
      //   $(this).next().toggleClass('disable')

      //   if ($(this).html() === "この質問に回答する！") {
      //     $(this).html("回答フォームを折りたたむ");
      //   }else{
      //     $(this).html("この質問に回答する！");
      //   }
      //   console.log($(this).html());
      // });

      // 解答者が質問者が同じなら、プロフィールを左へ
      // try{
      //   let answers_user_id = gon.answers_user_id;
      //   let question_user_id = gon.question_user_id;

      //   if (answers_user_id.length !== 0){
      //     answers_user_id.forEach (function (answer_user_id, i){
      //       if (answer_user_id === question_user_id) {

      //         $("#show profile.flex-row-reverse").eq(i).children('thumbnail').children('img').addClass("mr-4");
      //         $("#show profile.flex-row-reverse").eq(i).children('thumbnail').children('img').removeClass("ml-4");
      //         $("#show profile.flex-row-reverse").eq(i).removeClass("flex-row-reverse");
      //       }
      //     });
      //   }
      // } catch(e){
      //   //エラー（非ログイン）なら何もしない
      // }
    }

    { //user-new
      //パスワードの表示、非表示の切り替え
      $("#pw-check").change(function(){
        if ($(this).prop('checked')){
          $(".pw-form").attr('type','text');
        }else{
          $(".pw-form").attr('type','password');
        }
      });

    }

    {//user-edit
    function buildHTML(image) {
      var html =
        `
        <div class="prev-content">
          <img src="${image}", alt="preview" class="prev-image rounded d-block mx-auto", width="100", height="150">
        </div>
        `;
      return html;
    }

    // 画像が選択された時に発火します
    $(document).on('change', '.hidden_file', function () {
      // .file_filedからデータを取得して変数fileに代入します
      var file = this.files[0];
      // FileReaderオブジェクトを作成します
      var reader = new FileReader();
      // DataURIScheme文字列を取得します
      reader.readAsDataURL(file);
      // 読み込みが完了したら処理が実行されます
      reader.onload = function () {
        // 読み込んだファイルの内容を取得して変数imageに代入します
        var image = this.result;
        // プレビュー画像がなければ処理を実行します
        if ($('.prev-content').length == 0) {
          // 読み込んだ画像ファイルをbuildHTMLに渡します
          var html = buildHTML(image);
          // 作成した.prev-contentをiconの代わりに表示させます
          $('.prev-contents').prepend(html);
          // 画像が表示されるのでiconを隠します
          $('.photo-icon').hide();
        } else {
          // もし既に画像がプレビューされていれば画像データのみを入れ替えます
          $('.prev-content .prev-image').attr({ src: image });
        }
      };
    });

    }

  });
});

// let html =`<dl class="border-rounded">
//             <dt id="answer-<%= answer.id %>"><%= raw Rinku.auto_link(simple_format(h(answer.content))) %></dt>

//             <hr>

//             <!--質問者と回答者が同じなら左へ表示-->
//             <% if answer.user == @question.user %>
//               <profile class="d-flex align-items-center">
//                 <thumbnail>
//                   <% if answer.user.image? %>
//                     <%= link_to(image_tag(answer.user.image.url, size: '100x150', class: 'rounded d-block mr-4'), user_path(answer.user)) %>
//                   <% else %>
//                     <i class="fa fa-frown-o fa-5x mr-4"></i>
//                   <% end %>
//                 </thumbnail>
//                 <content>
//                   <p>投稿者名: <%= link_to answer.user.name, user_path(answer.user) %></p>
//                   <p>投稿日時: <%= simple_time(answer.created_at) %></p>
//                 </content>
//               </profile>
//             <% else %>
//               <profile class="d-flex align-items-center flex-row-reverse">
//                 <thumbnail>
//                   <% if answer.user.image? %>
//                     <%= link_to(image_tag(answer.user.image.url, size: '100x150', class: 'rounded d-block ml-4'), user_path(answer.user)) %>
//                   <% else %>
//                     <i class="fa fa-frown-o fa-5x ml-4"></i>
//                   <% end %>
//                 </thumbnail>
//                 <content>
//                   <p>投稿者名: <%= link_to answer.user.name, user_path(answer.user) %></p>
//                   <p>投稿日時: <%= simple_time(answer.created_at) %></p>
//                 </content>
//               </profile>
//             <% end %>
//           </dl>
//           <hr>
//         `;