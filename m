From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [PATCH 4/9] fbcon/fbdev: Add blanking notification
Date: Wed, 12 Jan 2005 10:43:08 -0000
Message-ID: <009001c4f893$87964630$0f01a8c0@max>
References: <20041221213648.89B701A0278@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CofyG-00039C-At
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Jan 2005 02:43:24 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CofyE-0005ii-Jp
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Jan 2005 02:43:24 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

Tony,

I've just switched to using this patch when I updated to 2.6.11-rc1 and I've 
noticed a problem. Basically my code which is monitoring FB_EVENT_BLANK 
events doesn't see any.

> diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> --- a/drivers/video/console/fbcon.c 2004-11-17 18:15:17 +08:00
> +++ b/drivers/video/console/fbcon.c 2004-12-21 05:55:41 +08:00
[...]
> + if (ops->blank_state != blank) {
> + if (info->fbops->fb_blank &&
> +     info->fbops->fb_blank(blank, info))
> + fbcon_generic_blank(vc, info, blank);
> +
> + ops->blank_state = blank;
> + }

I think this is the problem (in fbcon.c). Instead of calling 
info->fbops->fb_blank(blank, info)), I think this should call fb_blank(info, 
blank) (in fbmem.c) which can then make the fbops call itself.

If you agree, I'll send a patch (or you can patch it - I don't mind). Let me 
know...

Richard 



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
