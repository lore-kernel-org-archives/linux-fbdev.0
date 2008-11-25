From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: asynchronous resolution change
Date: Tue, 25 Nov 2008 09:36:10 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0811250934280.21179@anakin>
References: <333fec630811181704t19194e5et6d5299e2305f4401@mail.gmail.com>
	<Pine.LNX.4.64.0811190933200.27671@anakin>
	<333fec630811241752i616754f5wcde88e812a439b01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1L4tPJ-0008Pi-KP
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Nov 2008 08:36:29 +0000
Received: from wilson.telenet-ops.be ([195.130.132.42])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L4tPH-00019g-Mt for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Nov 2008 08:36:29 +0000
In-Reply-To: <333fec630811241752i616754f5wcde88e812a439b01@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jatin Kumar <jatin.kumar@gatech.edu>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, 24 Nov 2008, Jatin Kumar wrote:
> On Wed, Nov 19, 2008 at 3:35 AM, Geert Uytterhoeven <geert@linux-m68k.org>wrote:
> > On Tue, 18 Nov 2008, Jatin Kumar wrote:
> > > I am new to linux fb model and had some queries regarding resolution
> > change
> > > mechanisms.
> > >
> > > Consider a situation where the frambuffer kernel module (vfb/xenfb etc)
> > > wants to change the resolution.
> > >
> > > 1. Is there a mechanism to this, considering the applications/windowing
> > > system/console above the framebuffer hasnt initiated the size change?
> > >
> > > 2. Is there a way to do an upcall into the application/windowing
> > > system/console modules to inform them about the size change
> > asynchronously?
> > >
> > > In this particular case ; the display hardware(instead of the user) has
> > > initiated the resolution change.Is it possible in the current fb
> > framework
> > > to support it?
> >
> > Yes there is! If the resolution is changed, and the number of columns and
> > lines of the console changes, the tty subsystem will send the SIGWINCH
> > signal
> > to the application, cfr. tty_do_resize() in drivers/char/tty_io.c.
> >
> > Note that not all applications handle it. E.g. X doesn't, AFAIK.
> 
> Thanks much for the info.
> 
> Is the tty_io_resize( ) relatively new? .

tty_do_resize

> I am looking at 2.6.18.8 src code (used for xen) and could not find the
> function.

No, it's older than the frame buffer device framework. If you can't find it,
search for SIGWINCH.

> Also are there any plans for exposing a similar callback api in the linux fb
> model to make the applications stay updated about the underlying
> resolution/hardware mode changes?

What exactly are you missing that SIGWINCH doesn't provide?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
