/**
 * Created by sparrow on 1/12/17.
 */
(function(){

        var hostname = window.location.hostname;
        var user = {
            id: '',
            firstName: '',
            middleName: '',
            lastName: ''
        };

        $.getJSON("http://"+ hostname +"/dialog/user", function(data) {
            user.id = data.id;
            user.firstName = data.firstName;
            user.middleName = data.middleName;
            user.lastName = data.lastName;
        });

        var conn = new WebSocket('ws://'+hostname+':8080');
        conn.onopen = function(e) {
            console.log("Connection established!");
        };

        conn.onmessage = function(e) {
            var msg = JSON.parse(e.data);
            updateDialogs(msg); //
            updateMessages(msg, true);
        };

        $('#send-msg').click( function(){
            var text = $('#msg').val();
            var msg = {
                'userId': user.id,
                'roomId': $( "ul.chat:visible" ).attr("chat-id"),
                'roomName' : $( "ul.dialog-list li.active").find('strong').text(),
                'user': user.firstName + " " + user.middleName + " " + user.lastName,
                'text': text,
                'time': moment().format('YYYY-MM-DD HH:mm:ss')
            };
            updateMessages(msg, false);
            conn.send(JSON.stringify(msg));
            $('#msg').val('');
        });

    function createDialog(roomId, roomName) {
        $("li.active").removeClass("active ");
        $("ul.chat:visible").hide();
        $('<li class="active " dialog-id="' + roomId + '">' +
            '<a href="#" class="clearfix">' +
            '<div class="friend-name">' +
            '<strong>' + roomName + '</strong>' +
            '</div>' +
            '<div class="last-message text-muted"><i>сообщений нет...</i></div>' +
            '<small class="time text-muted"></small>'+
            '<small class="chat-alert label label-danger"></small>' +
            '</a>' +
            '</li>').prependTo($('ul.dialog-list'));
        $('<ul class="chat" chat-id="' + roomId + '"></ul>').prependTo($('div.chat-area')).show();
    }

    function updateDialogs(msg){
            if (!$('ul.dialog-list').find('li[dialog-id="' + msg.roomId +'"]').length) {
                createDialog(msg.roomId, msg.roomName);
                $( "ul.chat[chat-id=" + msg.roomId + "]" ).show();
            }
                $.post("http://"+hostname+"/dialog/addunread",
                    {dialogId: msg.roomId, userId: user.id }
                    , function(data) {
                        $('ul.dialog-list li[dialog-id="' + msg.roomId +'"] a small.chat-alert').text(data.unreadCounter);
                    },
                    'json'
                );

               $('ul.dialog-list li[dialog-id="' + msg.roomId +'"] div.last-message.text-muted').text(msg.text);

               $('ul.dialog-list li[dialog-id="' + msg.roomId +'"] a small.time').text(msg.time);
        }

        //flag true - received message
        //flag false - sent message
        function updateMessages(msg, flag){
            var sendClass = 'chat-message dark';
            var sideClass = 'right'
            if (flag){
                sendClass = 'chat-message';
                sideClass = 'left'
            }

            var li = $('<li/>', {
                class:  sideClass+' clearfix'
            });

            li.append(
                $('<span/>', { class:  'chat-img pull-'+sideClass}).append(
                    $('<img />', {
                        src: '/app/templates/w3images/avatar3.png',
                        alt: 'MyAvatar',
                        })
                ),
                $('<div/>', { class:  'chat-body clearfix'}).append(
                    $('<div/>', { class:  'header'}).append(
                        $('<strong/>', { class:  'primary-font', text: msg.user }),
                        $('<small/>', { class:  'pull-right text-muted' }).append(
                            $("<i/>",{ class: 'fa fa-clock-o', text:' '+msg.time })
                        )
                    ),
                    $('<p/>', { class:  sendClass, text: msg.text})
                )
            );

            $('ul[chat-id="' + msg.roomId +'"]').append(li);

            $('div.chat-area').animate({scrollTop: $('div.chat-area').prop("scrollHeight")}, 1000);
        }

    $('#create-dialog').click( function() {
        var dialogName = $('#dialog-name').val();
        var dialogId;
        var friends = $('ul.chosen-choices').find($( "li.search-choice" ));
        var friendIds = [];

        friends.each(function() {
            friendIds.push($( this ).attr( "uid" ));
        });
        if (dialogName != "") {
            if (friendIds.length > 0) {
                $.post("http://"+ hostname +"/dialog/create",
                    {
                        friendIds: friendIds,
                        dialogName: dialogName
                    },
                    function (dialogId) {
                        createDialog(dialogId,dialogName);
                        console.log(dialogId);
                        //alert();
                    },
                    'json'
                );

                $('#myModal').modal('toggle');
            } else {
                $('div.chosen-container').append(
                    $('<div/>', {
                        class: 'alert alert-danger alert-dismissable',
                        text: "Empty receiver's list"
                    }).append(
                        $('<a/>', {
                                href: '#',
                                class: 'close',
                                'data-dismiss': 'alert',
                                'aria-label': 'close',
                                text: 'x'
                            }
                        )
                    )
                );
            }
        } else {
            $('div.chosen-container').append(
                $('<div/>', {
                    class: 'alert alert-danger alert-dismissable',
                    text: "Empty dialog's name"
                }).append(
                    $('<a/>', {
                            href: '#',
                            class: 'close',
                            'data-dismiss': 'alert',
                            'aria-label': 'close',
                            text: 'x'
                        }
                    )
                )
            );
        }

    });

    $(document).on('click', "ul.dialog-list li", function(){


        $('ul.dialog-list li').removeClass("active ");
        $('div.chat-area ul.chat:visible').hide();

        $( this ).addClass("active ");
        var roomId = $( this ).attr( "dialog-id" );
        $( "ul.chat[chat-id=" + roomId + "]" ).show();

        $(this).find('small.chat-alert').text('');

        $('div.chat-area').animate({scrollTop: $('div.chat-area').prop("scrollHeight")}, 1000);

        $.post("http://"+ hostname +"/dialog/clearunread", {roomId: roomId , clearUnread: true});
    });

        $('.chosen-select').chosen();
        $('.chosen-select-deselect').chosen({ allow_single_deselect: true });

        $('ul.chat:first').show();
        $('ul.dialog-list li:first').addClass("active ")

})();