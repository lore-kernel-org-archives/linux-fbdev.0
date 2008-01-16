From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Bugme-new] [Bug 9762] New: radeonfb and
 Xpress 200m 5955
Date: Wed, 16 Jan 2008 16:23:22 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801161622060.7015@anakin>
References: <bug-9762-10286@http.bugzilla.kernel.org/>
	<20080116015707.4d551245.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFA7U-0008VI-2h for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jan 2008 07:24:00 -0800
Received: from ananke.telenet-ops.be ([195.130.137.78])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JFA7R-0001rD-8b
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jan 2008 07:23:59 -0800
In-Reply-To: <20080116015707.4d551245.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Sellout Bessie <sellout@beautyisfleeting.com>, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>, alevkovich@tut.by, "Antonino A. Daplas" <adaplas@pol.net>

On Wed, 16 Jan 2008, Andrew Morton wrote:
> On Wed, 16 Jan 2008 01:33:25 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
> > http://bugzilla.kernel.org/show_bug.cgi?id=9762
> > 
> >            Summary: radeonfb and Xpress 200m 5955
> >            Product: Drivers
> >            Version: 2.5
> >      KernelVersion: >=2.6.23
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Console/Framebuffers
> >         AssignedTo: jsimmons@infradead.org
> >         ReportedBy: alevkovich@tut.by
> > 
> > 
> > Latest working kernel version: 2.6.23
> > Earliest failing kernel version: any
> > Distribution: gentoo
> > Hardware Environment: Radeon XPress 200m 5955
> > Software Environment: 
> > Problem Description: framebuffer is ok only with default parameters only (it is
> > 1280x800-8@60). If parameters are video=radeonfb:1280x800-32@60 then xres, yres
> > and xres_virtual are ok but yres_virtual is 1024. It can be corrected by fbset
> > utility so I think it can be corrected in the driver code also.
> > 
> > Steps to reproduce: video=radeonfb:1280x800-32@60 or
> > video=radeonfb:1280x800-16@60
> 
> damn, another post-2.6.2 regression.
> 
> Does anyone know whether this is likely to be a radeonfb problem or an
> fbdev core problem?

Perhaps

commit 1c5dd170927b1aa8e3a01d43d611b840336cdaf2
Author: Michal Januszewski <spock@gentoo.org>
Date:   Tue Oct 16 01:29:19 2007 -0700

    fbdev: find mode with the highest/safest refresh rate in fb_find_mode()
    
    Currently, if the refresh rate is not specified, fb_find_mode() returns the
    first known video mode with the requested resolution, which provides no
    guarantees wrt the refresh rate.  Change this so that the mode with the
    highest refresh rate is returned when the driver provides a custom video mod
e
    database and the monitor limits, and a mode with the safe 60 Hz refresh rate
    otherwise.

M. alevkovich, can you please try to back out that change?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
