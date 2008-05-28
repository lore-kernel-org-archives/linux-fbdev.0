From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: DirectFB without FBDev
Date: Wed, 28 May 2008 19:55:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805281948080.15083@anakin>
References: <483D7344.6030503@directfb.org>
	<Pine.LNX.4.64.0805281901300.15083@anakin>
	<483D9453.1080700@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1Ps1-0002sN-NZ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 10:55:29 -0700
Received: from winston.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1Ps0-0002qd-QS
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 10:55:29 -0700
In-Reply-To: <483D9453.1080700@directfb.org>
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
To: Denis Oliver Kropp <dok@directfb.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, directfb-users@directfb.org, directfb-dev@directfb.org

On Wed, 28 May 2008, Denis Oliver Kropp wrote:
> Geert Uytterhoeven wrote:
> > On Wed, 28 May 2008, Denis Oliver Kropp wrote:
> > > One major bug at the moment is mode switching and pitch values being
> > > wrong. It's dumb to
> > > return the pitch of the variable mode settings in the fixed settings
> > > structure anyhow, but
> > > if you like to start with the above mentioned mission, that's where it
> > > could begin.
> > 
> > Do you care to tell us why this is dumb?
> 
> Ok, the fixed information should not contain information that changes over
> time,
> otherwise it is not fixed, at least that's my understanding of "fixed".

It's `fixed' not in the sense that it can never change, but that it
purely depends on the info in struct fb_var_screeninfo.

> > The pitch depends on the video mode and the hardware requirements,
> > that's why it's in struct fb_fix_screeninfo.
> 
> It would suffice to encode the pitch requirements independent from the video
> mode,
> i.e. just put the pixel or byte alignment into the fixed structure.

What if the pitch requirements depend on the video mode?

There exists graphics hardware where fb_fix_screeninfo.type depends on
the video mode.

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
