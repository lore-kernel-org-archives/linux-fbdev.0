From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: vfb updates.
Date: Fri, 23 Apr 2004 10:44:01 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404231043280.11983@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404221915320.24337-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGwI6-0001Rd-HT
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 01:44:10 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGwI6-0000Ya-5C
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 01:44:10 -0700
In-Reply-To: <Pine.LNX.4.44.0404221915320.24337-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 22 Apr 2004, James Simmons wrote:
> This patch updates the Virtual framebuffer to use the
> frmaebuffer_alloc/release functions.
>
> --- linus-2.6/drivers/video/vfb.c	2004-02-12 18:31:45.000000000 -0800
> +++ fbdev-2.6/drivers/video/vfb.c	2004-04-21 17:46:38.000000000 -0700
> @@ -72,7 +69,7 @@
>  	.accel =	FB_ACCEL_NONE,
>  };
>
> -static int vfb_enable __initdata = 0;	/* disabled by default */
> +static int vfb_enable __initdata = 1;	/* disabled by default */
>  MODULE_PARM(vfb_enable, "i");
>
>      /*

Please revert this hunk! You do _not_ want to enable vfb by default!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
