From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Apollo framebuffer sysfs
Date: Tue, 24 Feb 2004 09:32:27 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402240931140.3187@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402232216120.11599-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvY7Y-0005aN-GI
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 00:40:52 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvXzS-0001vP-Bs
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 00:32:30 -0800
In-Reply-To: <Pine.LNX.4.44.0402232216120.11599-100000@phoenix.infradead.org>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 23 Feb 2004, James Simmons wrote:
> > Wow, the first platform_device on m68k ;-)
>
> :-)
>
> Merged with my patch. This patch is against linus tree. Please test.
>
>
> --- linus-2.6/drivers/video/dnfb.c	2004-02-18 20:59:07.000000000 -0800
> +++ fbdev-2.6/drivers/video/dnfb.c	2004-02-22 21:17:16.000000000 -0800

You missed these:
  - Kill space at end of line
  - Kill unneeded initialization

--- linux/drivers/video/dnfb.c.orig	2004-02-24 09:28:19.000000000 +0100
+++ linux/drivers/video/dnfb.c	2004-02-23 20:59:20.000000000 +0100
@@ -246,7 +246,7 @@
 		framebuffer_release(info);
 		return err;
 	}
-
+
 	err = register_framebuffer(info);
 	if (err < 0) {
 		fb_dealloc_cmap(&info->cmap);
@@ -275,7 +275,6 @@

 static struct platform_device dnfb_device = {
 	.name	= "dnfb",
-	.id	= 0,
 };

 int __init dnfb_init(void)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
