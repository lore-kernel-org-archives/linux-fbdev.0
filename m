From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] framebuffer on 4 MegaHertz FPGA
Date: Sat, 20 Mar 2004 11:12:39 +0100 (MET)
Sender: linux-fbdev-users-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403201110100.19694@waterleaf.sonytel.be>
References: <405BBEA3.4040000@GameBox.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-users-admin@lists.sourceforge.net>
In-Reply-To: <405BBEA3.4040000@GameBox.net>
Errors-To: linux-fbdev-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-users@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-users>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Suresh Chandra Mannava <Mannava@GameBox.net>
Cc: linux-fbdev-users@lists.sourceforge.net, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 20 Mar 2004, Suresh Chandra Mannava wrote:
> We are facing the problem of initializing the framebuffer for the below
> system.
> We are porting Xfree86 on to a new 32bit RISC processor. We have test
> FPGA system running at 4 Mega Hertz (Bogomips 0.16) on kernel 2.4.7.
> proposed system(ASIC) runs on ~300Mhz.
>
> My main concern is does Xfree86 can be tested on 2.6Mhz FPGA?
> What is the minimum clock speed required to run X?

> Our test system supports 2GB of RAM and it consists of PCI ATI Rage XL
> Graphics card.

> We think that speed might be a problem.We need to findout first whether
> we will be able to run a framebuffer driver at 4 MHZ.Since framebuffer
> does pixel by pixel access,we think it will take a lot of time and
> anything can happen in between.We are now not in a position to predict
> what is happening.Please give your points on whether the framebuffer
> will work at such a low speed.
>
> I request your suggestions on feasibility of initializing framebuffer
> and testing X on the above system.

Since X was developed in mid-1980s (using unaccelerated graphics hardware) it
can definitely run on such slow CPU. Ater all your graphics card is quite fast.

And fbdev was developed on m68k machines, running on 16-50 MHz CPUs with
unaccelerated graphics hardware as well.

Of course you don't want to try GNOME and KDE, but simple things like twm and
xterm should be usable.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
