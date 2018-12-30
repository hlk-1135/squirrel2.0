
$(document).ready(function(){

    var login = $('#loginform');
    var recover = $('#recoverform');
    var speed = 400;

    $('#to-recover').click(function(){

        $("#loginform").slideUp();
        $("#recoverform").fadeIn();
    });
    $('#to-login').click(function(){

        $("#recoverform").hide();
        $("#loginform").fadeIn();
    });


    $('#to-login').click(function(){

    });

    if($.browser.msie == true && $.browser.version.slice(0,3) < 10) {
        $('input[placeholder]').each(function(){

            var input = $(this);

            $(input).val(input.attr('placeholder'));

            $(input).focus(function(){
                if (input.val() == input.attr('placeholder')) {
                    input.val('');
                }
            });

            $(input).blur(function(){
                if (input.val() == '' || input.val() == input.attr('placeholder')) {
                    input.val(input.attr('placeholder'));
                }
            });
        });
    }
});

function check(){
    var name = $("#name").val();
    var password = $("#password").val();
    if(name==null || name==""){
        alert("请输入用户名");
        return false;
    }

    if(password==null || password==""){
        alert("请输入密码");
        return false;
    }
    return true;
};
