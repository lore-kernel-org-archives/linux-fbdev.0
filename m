From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] pxafb: Add support for other
 palette formats
Date: Tue, 3 Jul 2007 17:58:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707031756490.13482@anakin>
References: <200707031607.08511.hjk@linutronix.de>
	<468A6159.6000808@grupopie.com>
	<200707031703.53102.hjk@linutronix.de>
	<18058.28725.106989.860166@ipc1.karo>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5km0-00005m-9Z for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:58:40 -0700
Received: from ananke.telenet-ops.be ([195.130.137.78])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5kly-00014o-Uk
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:58:40 -0700
In-Reply-To: <18058.28725.106989.860166@ipc1.karo>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Thomas Gleixner <tglx@linutronix.de>, Paulo Marques <pmarques@grupopie.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, 3 Jul 2007, Lothar Wassmann wrote:
> > Can userspace applications work with such a weired format?
> > If yes, I'm looking forward to your patch.
> > 
> At least framebuffer consoles don't work with that. So you should
> add a configuration option that allows enabling the strange PXA pixel
> formats only when CONFIG_FRAMEBUFFER_CONSOLE is not set.

Of course framebuffer consoles handle that!

Just make sure to implement proper fb_ops.fb_{fillrect,copyarea,imageblit}().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
