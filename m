From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK PATCHS] fbdev updates.
Date: Fri, 18 Oct 2002 09:48:09 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210180948070.10832-100000@maxwell.earthlink.net>
References: <Pine.GSO.4.21.0210151036400.25245-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182aOX-0003Gp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 09:54:41 -0700
In-Reply-To: <Pine.GSO.4.21.0210151036400.25245-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Done.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

On Tue, 15 Oct 2002, Geert Uytterhoeven wrote:

> On Mon, 14 Oct 2002, James Simmons wrote:
> > > On Sun, 13 Oct 2002, James Simmons wrote:
> > > > This is nearly the last of the fbdev api changes (90% of them). Alot of
> > > > driver fixes as well. The console related stuff in each fbdev driver
> > > > is nearly gone!!! Please do a pull. Thank you.
> > > >
> > > > bk://fbdev.bkbits.net/fbdev-2.5
> > >
> > > Please add the output of diffstat, so we know which files you changed.
> >
> > Better yet here is the BK patch via email.
> > @@ -220,12 +218,7 @@
> >     bool '  Advanced low level driver options' CONFIG_FBCON_ADVANCED
> >     if [ "$CONFIG_FBCON_ADVANCED" = "y" ]; then
> >        tristate '    Monochrome support' CONFIG_FBCON_MFB
>
> CONFIG_FBCON_MFB can be deleted, because of this change to the Makefile:
>
> > -obj-$(CONFIG_FBCON_MFB)           += fbcon-mfb.o
>
> >  #      tristate '    Atari interleaved bitplanes (16 planes) support' CONFIG_FBCON_IPLAN2P16
>
> FBCON_IPLAN2P16 can be deleted, since it doesn't exist.
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
>
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
