From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: vga framebuffer for new architecture
Date: Mon, 14 Jun 2004 15:17:52 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406141511510.21656@waterleaf.sonytel.be>
References: <20040614123118.5378.qmail@web8201.mail.in.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BZrLZ-000539-Sj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Jun 2004 06:17:57 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BZrLY-0000NN-NT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Jun 2004 06:17:56 -0700
In-Reply-To: <20040614123118.5378.qmail@web8201.mail.in.yahoo.com>
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
To: =?iso-8859-1?q?Suresh=20Chandra=20Mannava?= <hardsuresh@yahoo.co.in>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 14 Jun 2004, [iso-8859-1] Suresh Chandra Mannava wrote:
> 		We have struck with the following problem. We will
> make a summary of it. Please help us in this regard.
> We are working with a 2.6 MHZ(mega hz) FPGA processor.
> We have successfully ported linux onto the system.Now
> we are porting generic frame buffer (vga16fb) onto the
> processor. We have ATIRAGE XL graphics card on the pci
> slot. Please help us for the following queries.
>
> 	1) Is it possible to make the generic VGA16
> FrameBuffer  work on a such a slow 2.6MHZ(Mega HZ)
> processor?

Sure, why not?

> 	2) Are there any Hardware dependencies specific to
> new platform for VGA16 Generic Frame buffer?

You have to execute (or emulate) the BIOS code of your graphics card to
initialize it to VGA text mode before you can use vga16fb.

> 	3)What is the function of visual_init in
> char/console.c?

To initialize the hardware-dependent part of the console driver (through
sw->con_init()).

> 	4)whether the loop inside take_over_console which
> executes 64 times is really needed?

Yes, the hardware-dependent part of the console driver is aware of the virtual
consoles, so it needs to initialize all of them.

> (register_framebuffer passes a value of 63 to
> last_console variable). In intel platform we found
> that it is ok to execute the loop only once.

Really? What if you switch to a different virtual console?

> 	 We found that in our case the loop is executing only
> once even though the loop count is 64.It seems to be
> hanging somewhere near fbcon_init in video/fbcon.c
> called from visual_init.

I see no way (in 2.4.26) to escape from the loop, though.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
