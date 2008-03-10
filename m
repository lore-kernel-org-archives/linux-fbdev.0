From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PM/FB/gxfb: add config option that allows
	disabling of VT	switch during suspend
Date: Tue, 11 Mar 2008 00:06:12 +0100
Message-ID: <20080310230612.GB31750@elf.ucw.cz>
References: <20080308204927.73afa56c@ephemeral>
	<20080310141939.ce1169c0.akpm@linux-foundation.org>
	<20080310174424.29621e62@ephemeral>
	<20080310145118.adb0cf1e.akpm@linux-foundation.org>
	<20080310181446.2fb85eea@ephemeral>
	<20080310222407.GD589@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYr3s-0005e7-So for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 16:05:41 -0700
Received: from gprs189-60.eurotel.cz ([160.218.189.60])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JYr3o-0004W7-W2
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 16:05:40 -0700
Content-Disposition: inline
In-Reply-To: <20080310222407.GD589@cosmic.amd.com>
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
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, info-linux@geode.amd.com, rjw@sisk.pl, samuel.thibault@ens-lyon.org, Andrew Morton <akpm@linux-foundation.org>

Hi!

> > > > If so, that means extra #ifdef's sprinkled throughout the code.  Note
> > > > that most framebuffer drivers won't be supporting this, and those that
> > > > do will almost certainly always want vt switching turned off..
> > > > 
> > > 
> > > I don't think you need any ifdefs or config options at all, do you?  Just
> > > add a new module parameter to this driver and some little interface into
> > > the PM core which allows the driver to set no_vt_switch?
> > > 
> > 
> > That's a possibility, but doesn't adding hooks into PM core for two
> > drivers (lxfb and gxfb) seems like overkill?  I also don't really see
> > anyone needing to switch back and forth between VT_SWITCH and
> > NO_VT_SWITCH other than to work around possible bugs in the register
> > save/restore code..
> 
> I like Andrew's idea.  I wager This won't be Geode specific for long.
> Either other drivers will get the hint and add real save/restore code
> or the GPU subystem code being worked on by the X folks will come along
> and make the VT switch obsolete for everybody.  Either way, I see hooks
> in the PM core as generic love that everybody can benefit from.

Exactly. We'd like _all_ drivers to behave like this.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
