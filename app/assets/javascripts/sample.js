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

      // 押したソートへのリンクの背景を変える
      $("#sort-btn-wrap > a").click(function(e){
        let index = $("#sort-btn-wrap > a").index(this);
        document.addEventListener("turbolinks:load", function() {
          $(function() {
            $("#sort-btn-wrap > a").removeClass("active");
            $("#sort-btn-wrap > a").eq(index).addClass("active");
          });
        });
      });

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
    //プレビュー機能
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


