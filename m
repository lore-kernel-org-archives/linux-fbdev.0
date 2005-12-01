From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: scroll modes
Date: Fri, 02 Dec 2005 07:16:55 +0800
Message-ID: <438F8467.60403@gmail.com>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be> <438DE211.2060900@t-online.de> <438E0E23.2000203@gmail.com> <438E2D8E.2040503@t-online.de> <438E3D66.8080601@gmail.com> <438F8136.5030005@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ehxgk-0007JX-T2
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 15:18:06 -0800
Received: from zproxy.gmail.com ([64.233.162.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ehxgi-0001Z8-CK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 15:18:06 -0800
Received: by zproxy.gmail.com with SMTP id z3so109572nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Dec 2005 15:18:03 -0800 (PST)
In-Reply-To: <438F8136.5030005@t-online.de>
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
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Knut Petersen wrote:
> Hi Geert/Antonino,
> 
> YWRAP_MOVE now does work on the cyberblade/i1. The following change
> to bitblit.c is necessary:
> 
> static int bit_update_start(struct fb_info *info)
> {
>        struct fbcon_ops *ops = info->fbcon_par;
>        int err;
> 
> -         err = fb_pan_display(info, &ops->var);
> +        err = info->fbops->fb_pan_display(&ops->var,info);;

Well, no.  If there is something wrong with fb_pan_display() let's fix that.
I don't want any code calling fbops->fb_pan_display() directly.

What's wrong with fb_pan_display() that requires fixing?

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
