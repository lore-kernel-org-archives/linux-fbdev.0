From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: DirectFB without FBDev
Date: Wed, 28 May 2008 19:04:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805281901300.15083@anakin>
References: <483D7344.6030503@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1P4l-0005nX-Ks for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 10:04:36 -0700
Received: from winston.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1P4k-0001Jq-6S
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 10:04:35 -0700
In-Reply-To: <483D7344.6030503@directfb.org>
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

	Hi Denis,

On Wed, 28 May 2008, Denis Oliver Kropp wrote:
> One major bug at the moment is mode switching and pitch values being wrong. It's dumb to
> return the pitch of the variable mode settings in the fixed settings structure anyhow, but
> if you like to start with the above mentioned mission, that's where it could begin.

Do you care to tell us why this is dumb?

The pitch depends on the video mode and the hardware requirements,
that's why it's in struct fb_fix_screeninfo.

> And while you're at it, please also add an ioctl to just simply set the display offset without
> a virtual resolution and x/y offset values within the whole frame buffer...

Why do you need this? What's different compared to setting a virtual
resolution and a y offset (I assume you're talking about y only, as an x
offset without a virtual resolution doesn't make much sense).

Thanks!

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
