From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/5][RFC] fbdev: Clean up framebuffer
 initialization
Date: Sun, 5 Sep 2004 11:16:25 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409051113060.28961@waterleaf.sonytel.be>
References: <200409041108.40276.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3t8S-0000jw-67
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 02:16:32 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C3t8Q-0002aZ-8Y
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 02:16:31 -0700
In-Reply-To: <200409041108.40276.adaplas@hotpop.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Thomas Winischhofer <thomas@winischhofer.net>

On Sat, 4 Sep 2004, Antonino A. Daplas wrote:
> Currently, the framebuffer system is initialized in a roundabout manner.
> First, drivers/char/mem.c calls fbmem_init().  fbmem_init() will then
> iterate over an array of individual drivers' xxxfb_init(), then each driver
> registers its presence back to fbmem.  During console_init(),
> drivers/char/vt.c will call fb_console_init(). fbcon will check for
> registered drivers, and if any are present, will call take_over_console() in
> drivers/char/vt.c.
>
> This patch changes the initialization sequence so it proceeds in this
> manner: Each driver has its own module_init(). Each driver calls
> register_framebuffer() in fbmem.c. fbmem.c will then notify fbcon of the
> driver registration.  Upon notification, fbcon calls take_over_console() in
> vt.c.

My main concern with this change is that it will be no longer possible to
change initialization order (and hence choose the primary display for systems
with multiple graphics adapters) by specifying `video=xxxfb' on the kernel
command line.

That's also the reason why this was never done before.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
