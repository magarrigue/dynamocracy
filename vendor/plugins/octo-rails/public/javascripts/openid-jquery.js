/*
Simple OpenID Plugin
http://code.google.com/p/openid-selector/

This code is licenced under the New BSD License.
*/

var providers_large = {
    google: {
        name: 'Google',
        url: 'https://www.google.com/accounts/o8/id'
    },
    yahoo: {
        name: 'Yahoo',
        url: 'http://yahoo.com/'
    },
    myopenid: {
        name: 'MyOpenID',
        label: 'Enter your MyOpenID username.',
        url: 'http://{username}.myopenid.com/'
    },
    aol: {
        name: 'AOL',
        label: 'Enter your AOL screenname.',
        url: 'http://openid.aol.com/{username}'
    }
};

var providers_small = {
  octo_openid: {
      name: 'Octo_Openid',
      label: 'Your OCTO Technology Trigram',
      url: 'https://openid.octo.com/users/{username}'
  },
    livejournal: {
        name: 'LiveJournal',
        label: 'Enter your Livejournal username.',
        url: 'http://{username}.livejournal.com/'
    },
    wordpress: {
        name: 'Wordpress',
        label: 'Enter your Wordpress.com username.',
        url: 'http://{username}.wordpress.com/'
    },
    blogger: {
        name: 'Blogger',
        label: 'Your Blogger account',
        url: 'http://{username}.blogspot.com/'
    },
    verisign: {
        name: 'Verisign',
        label: 'Your Verisign username',
        url: 'http://{username}.pip.verisignlabs.com/'
    },
    claimid: {
        name: 'ClaimID',
        label: 'Your ClaimID username',
        url: 'http://openid.claimid.com/{username}'
    },
    clickpass: {
        name: 'ClickPass',
        label: 'Your ClickPass username',
        url: 'http://clickpass.com/public/{username}'
    }, 
    google_profile: {
        name: 'Google_Profile',
        label: 'Your Google Profile username',
        url: 'http://www.google.com/profiles/{username}'
    }
};

var providers = $.extend({}, providers_large, providers_small);

var openid = {

    cookie_expires: 6 * 30, // 6 months.
    cookie_name: 'openid_provider',
    cookie_path: '/',

    img_path: '/images/openid/',

    input_id: null,
    provider_url: null,

    init: function(input_id) {

        // turn off hourglass
        $('body').css('cursor', 'default');
        $('#openid_submit').css('cursor', 'default');

        // enable submit button on form
        $('input[type=submit]').removeAttr('disabled');

        var openid_btns = $('#openid_btns');

        this.input_id = input_id;

        $('#openid_choice').show();
        $('#openid_input_area').empty();

        // add box for each provider
        for (id in providers_large) {
            openid_btns.append(this.getBoxHTML(providers_large[id], 'large', '.png'));
        }
        if (providers_small) {
            openid_btns.append('<br>');
            for (id in providers_small) {
                openid_btns.append(this.getBoxHTML(providers_small[id], 'small', '.png'));
            }
        }

        $('#openid_form').submit(this.submitx);

    },

    getBoxHTML: function(provider, box_size, image_ext) {

        var box_id = provider["name"].toLowerCase();
        return '<a title="' + provider["name"] + '" href="javascript: openid.signin(\'' + box_id + '\');"' +
        		' style="background: #FFF url(' + this.img_path + box_id + image_ext + ') no-repeat center center" ' +
        		'class="' + box_id + ' openid_' + box_size + '_btn"></a>';
    },

    /* provider image click */
    signin: function(box_id, onload) {

        var provider = providers[box_id];
        if (!provider) { return; }

        this.highlight(box_id);

        if (box_id == 'openid') {
            $('#openid_input_area').empty();
            this.setOpenIdUrl("");
            $("#openid_identifier").focus();
            return;
        }

        // prompt user for input?
        if (provider['label']) {
            this.useInputBox(provider);
            this.provider_url = provider['url'];
        } else {
            $('.' + box_id).css('cursor', 'wait');
            this.setOpenIdUrl(provider['url']);
            this.provider_url = null;
            if (!onload) {
                $('#openid_form').submit();
            }
        }
    },

    /* Sign-in button click */
    submitx: function() {
        if ($('#openid_username').val() == "") return true;

        // set up hourglass on body
        $('body').css('cursor', 'wait');
        $('#openid_submit').css('cursor', 'wait');
        // disable submit button on form
        $('input[type=submit]', this).attr('disabled', 'disabled');

        var url = openid.provider_url;
        if (url) {
            url = url.replace('{username}', $('#openid_username').val());
            openid.setOpenIdUrl(url);
        }
        return true;
    },

    setOpenIdUrl: function(url) {
        var hidden = $('#' + this.input_id);
        hidden.val(url);
    },

    highlight: function(box_id) {
        // remove previous highlight.
        var highlight = $('#openid_highlight');
        if (highlight) {
            highlight.replaceWith($('#openid_highlight a')[0]);
        }
        // add new highlight.
        $('.' + box_id).wrap('<div id="openid_highlight"></div>');
    },

    useInputBox: function(provider) {

        var input_area = $('#openid_input_area');

        var html = '';
        var id = 'openid_username';
        var value = '';
        var label = provider['label'];
        var style = '';

        if (label) {
            html = '<p>' + label + '</p>';
        }
        html += '<input id="' + id + '" type="text" style="' + style + '" name="' + id + '" value="' + value + '" />' +
					'<input id="openid_submit" type="submit" value="Sign-In"/>';

        input_area.empty();
        input_area.append(html);

        $('#' + id).focus();
    }
};