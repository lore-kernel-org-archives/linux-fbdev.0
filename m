From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: fbdv/fbcon pending problems
Date: Tue, 24 Feb 2004 09:37:12 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402240936270.3187@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402231823570.11599-100000@phoenix.infradead.org>
 <1077576644.5960.77.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvYCG-0006tZ-TZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 00:45:44 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AvXsD-0004zA-Sk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 00:25:02 -0800
In-Reply-To: <1077576644.5960.77.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tue, 24 Feb 2004, Benjamin Herrenschmidt wrote:
> On Tue, 2004-02-24 at 05:59, James Simmons wrote:
> > I think we should do better validating of the var passed in. This also
> > needs a bit of work.
>
> It does. Radeonfb did one step in this direction, but that's not
> enough. _BUT_ we still need to differenciate between a full mode
> passed from userland from a mode where we _KNOW_ everything is
> bogus but width/height... In the later case, we really want to
> find a mode that is just large enough for the passed in width/height
> (but not smaller, or just fail if not found) and with the same
> hfreq if possible as the current mode. That's really a different
> request than a full blown mode coming from userland (like a 'tuning'
> tool or whatever...)
>
> The FB_ACTIVATE_FIND is just that. It justs tells the driver to
> pick up a mode based on width/height only. We know the rest of
> the var is bogus.

What about renaming it to FB_ACTIVE_RESIZE?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
