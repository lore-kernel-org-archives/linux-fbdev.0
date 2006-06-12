From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Twister savagefb doesn't sync (resolved for
 640x480@64K)
Date: Mon, 12 Jun 2006 10:33:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0606121032430.7668@pademelon.sonytel.be>
References: <44698356.80806@iit.demokritos.gr> <44781B3A.5030406@gmail.com>
	<44781BFB.5020708@gmail.com> <447994A8.30600@iit.demokritos.gr> 
	<447A3CC0.9060403@gmail.com> <447AF58E.3050803@iit.demokritos.gr> 
	<447B60D7.8020204@gmail.com> <44845DEC.1000608@iit.demokritos.gr> 
	<a728f9f90606052211v43de97c7l91a22a9faa93f76c@mail.gmail.com> 
	<44855197.7040801@iit.demokritos.gr>
	<a728f9f90606060743t7fd6dfdfia3e2a050ff954e06@mail.gmail.com>
	<448C067B.3040404@iit.demokritos.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fphrf-00019W-UC for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 01:33:39 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fphrf-0001pI-NQ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 01:33:39 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fphrf-0001OX-8Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 01:33:39 -0700
In-Reply-To: <448C067B.3040404@iit.demokritos.gr>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: vasvir@iit.demokritos.gr, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Antonino A. Daplas" <adaplas@gmail.com>

On Sun, 11 Jun 2006, Vassilis Virvilis wrote:
> Alex Deucher wrote:
> > > > The reason the savage xorg drver uses the bios is because almost every
> > > > panel they connect to the chip seems to require fairly custom timings.
> > > > the twisters and prosavages are even worse than the discrete chips.
> > > > Also, only the bios seems to know the magic incantation necessary for
> > > > dualhead.  I tried for a while to add non-bios mode setting to crtc2
> > > > without much luck.
> > > 
> 
> When you say panel what do you mean?
> a) The rest of the framebuffer and scan logic resided in CRTC?
> b) The screen attached to CRTC?
> 
> I believe a) but I would like to know for sure.

panel = LCD panel (in contrast to CRT = Cathode Ray Tube)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
