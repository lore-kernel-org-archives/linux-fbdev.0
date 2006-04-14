From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [aty128fb]  fbset -a not working
Date: Fri, 14 Apr 2006 08:16:32 +0800
Message-ID: <443EE9E0.9080405@gmail.com>
References: <20060413034451.GA2846@prog3>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUBzh-0007Nb-3o
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Apr 2006 17:17:01 -0700
Received: from pproxy.gmail.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FUBzf-0005jG-LS
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Apr 2006 17:17:01 -0700
Received: by pproxy.gmail.com with SMTP id i49so2093537pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Apr 2006 17:16:58 -0700 (PDT)
In-Reply-To: <20060413034451.GA2846@prog3>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: goldenfish@bsys.cz

Pavel Kysilka wrote:
>    Hi,
> 
> i have ATI Rage128 AGP card.
> I was testing framebuffer. Switching resolution in one console working.
> Switching all consoles do not working. Only aktual console is switched.
> 

Can you insert debugging printk's in linux/drivers/video/fbmem.c:
fb_set_var()? It must reach this statement block with the FB_ACTIVATE_ALL
flag intact in order for setting all consoles to work:

			if (!err && (flags & FBINFO_MISC_USEREVENT)) {
				struct fb_event event;
				int evnt = (var->activate & FB_ACTIVATE_ALL) ?
					FB_EVENT_MODE_CHANGE_ALL :
					FB_EVENT_MODE_CHANGE;

				info->flags &= ~FBINFO_MISC_USEREVENT;
				event.info = info;
				blocking_notifier_call_chain(&fb_notifier_list,
						evnt, &event);
			}


Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
