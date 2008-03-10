From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 6/6] PM/FB/gxfb: add config option
	that allows	disabling of VT switch during suspend
Date: Tue, 11 Mar 2008 00:05:11 +0100
Message-ID: <20080310230511.GA31750@elf.ucw.cz>
References: <20080308204927.73afa56c@ephemeral>
	<20080310141939.ce1169c0.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYr2u-0005W1-AS for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 16:04:40 -0700
Received: from gprs189-60.eurotel.cz ([160.218.189.60])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JYr2r-0004FU-7U
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 16:04:40 -0700
Content-Disposition: inline
In-Reply-To: <20080310141939.ce1169c0.akpm@linux-foundation.org>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, info-linux@geode.amd.com, "Rafael J. Wysocki" <rjw@sisk.pl>, jordan.crouse@amd.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Mon 2008-03-10 14:19:39, Andrew Morton wrote:
> On Sat, 8 Mar 2008 20:49:27 -0500
> Andres Salomon <dilinger@queued.net> wrote:
> 
> > This is purely for suspend/resume time optimization.
> > 
> > 
> > >From 874aa20022a2501a30704163ed31a7baba7de9e5 Mon Sep 17 00:00:00 2001
> > From: Andres Salomon <dilinger@debian.org>
> > Date: Wed, 5 Mar 2008 16:40:25 -0500
> > Subject: [PATCH] PM: add config option that allows disabling of VT switch during suspend
> > 
> > Prior to suspend, we allocate and switch to a new VT; after suspend, we
> > switch back to the original VT.  This can be slow, and is completely
> > unnecessary if the framebuffer we're using can restore video properly.
> > 
> > This adds CONFIG_DISABLE_SUSPEND_VT_SWITCH which allows the user to
> > select whether or not to do that switch.  This has been tested with the
> > gxfb driver (on a Geode GX dev board and OLPC prototype machines).  In
> > order for the user to even see this option, a framebuffer has to declare
> > support for it (via CONFIG_FBDEV_SUPPORTS_NOSWITCH).
...
> It would be far preferable to do this via a kernel boot parameter rather
> than via a kernel rebuild.

Actually, it would be better to get this right automatically, without
any config options.

And no, this is not only gxfb/lxfb.  At least Sharp Zaurus and FIC
neo1973 can suspend without switching consoles... 
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
