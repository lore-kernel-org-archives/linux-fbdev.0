From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] export fb_blank in fbmem.c
Date: Tue, 31 Dec 2002 12:25:53 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212311225360.2037-100000@maxwell.earthlink.net>
References: <20021231091632.GA20498@schiele.local>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18TS9I-00019i-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 31 Dec 2002 11:34:00 -0800
In-Reply-To: <20021231091632.GA20498@schiele.local>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Schiele <rschiele@uni-mannheim.de>
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>


It will be in the next BK push

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

On Tue, 31 Dec 2002, Robert Schiele wrote:

> Hello.
>
> fb_blank() from fbmem.c is used in fbcon.ko, so this function should
> be exported.
>
> This is done by the following trivial fix.
>
> Robert
>
> --- linux-2.5.53/drivers/video/fbmem.c~	2002-12-31 09:28:23.000000000 +0100
> +++ linux-2.5.53/drivers/video/fbmem.c	2002-12-31 09:28:45.000000000 +0100
> @@ -930,5 +930,6 @@
>  EXPORT_SYMBOL(unregister_framebuffer);
>  EXPORT_SYMBOL(registered_fb);
>  EXPORT_SYMBOL(num_registered_fb);
> +EXPORT_SYMBOL(fb_blank)
>
>  MODULE_LICENSE("GPL");
>
> --
> Robert Schiele			Tel.: +49-621-181-2517
> Dipl.-Wirtsch.informatiker	mailto:rschiele@uni-mannheim.de
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
