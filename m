From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: Framebuffer console not working with
 matroxfb on 2.6
Date: Fri, 17 Sep 2004 13:50:56 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409171349430.19914@waterleaf.sonytel.be>
References: <3B9599C3EB4@vcnet.vc.cvut.cz> <20040917085131.GQ18257@uvt316-2.ruk.cuni.cz>
 <Pine.GSO.4.58.0409171151540.19914@waterleaf.sonytel.be>
 <200409171921.50273.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8HGX-0008Ho-Ph
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 04:51:01 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C8HGU-0003Rz-UE
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 04:51:01 -0700
In-Reply-To: <200409171921.50273.adaplas@hotpop.com>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 17 Sep 2004, Antonino A. Daplas wrote:
> On Friday 17 September 2004 17:53, Geert Uytterhoeven wrote:
> > On Fri, 17 Sep 2004, Michal 'hramrach' Suchanek wrote:
> > > However, I still get a minor problem with the driver.
> > > When I switch between the default 640x480-60 mode and 1024x768-85 mode
> > > the 1024x768 gets interlaced, with completely different timings. I have
> > > to use fbset to restore it to 1024x768-85.
> >
> > I think this is a `feature' of the new mode selection code. When I tried
> > booting my Radeon with `1024x768@100', I got 87 Hz interlaced...
>
> Michal's problem is more of a failure to preserve the per-display var, which
> should be fixed with recent mm or rc kernels.
>
> Yours is more of boot mode selection problem and most drivers use
> fb_find_mode() for that.  The default modedb does not have 1024x768@100
> non-interlaced, so it passed the interlaced version to the driver, which it
> happily accepted.  Thus, you get the interlaced version.

Modedb does have that mode! Before I've been using it for years on my PPC box.

linux-2.6.8.1/drivers/video/modedb.c:

    }, {
        /* 1024x768 @ 100Hz, 80.21 kHz hsync */
        NULL, 100, 1024, 768, 8658, 192, 32, 21, 3, 192, 10,
        0, FB_VMODE_NONINTERLACED
    }, {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
