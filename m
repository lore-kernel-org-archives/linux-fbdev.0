From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbdev upstream
Date: Mon, 5 Jan 2004 15:41:06 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0401051538300.3740@waterleaf.sonytel.be>
References: <3FD6C52C.7090906@undead.cc>  <3FDBB97F.4070207@undead.cc> 
 <1072254049.739.61.camel@gaston>  <3FE9F9C3.20605@undead.cc>
 <1072305777.15461.13.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdVur-0000Wm-JC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 06:41:13 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AdVur-0007xx-2T
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 06:41:13 -0800
In-Reply-To: <1072305777.15461.13.camel@gaston>
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
Cc: John Zielinski <grim@undead.cc>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 25 Dec 2003, Benjamin Herrenschmidt wrote:
> On Thu, 2003-12-25 at 07:40, John Zielinski wrote:
> The idea is that fbcon will use FB_ACTIVATE_FIND instead of
> FB_ACTIVATE_TEST, which I defined to be "pick a mode suitable for the
> display based solely on xres/yres). In radeonfb, when you enable the

Can't you overload the `round up if it doesn't fit' rule to achieve this,
instead of by adding FB_ACTIVATE_FIND?

I.e. the procedure becomes:

    memset(var, 0, sizeof(*var);
    var.xres = wanted_xres;
    var.yres = wanted_yres;
    var.bits_per_pixel = wanted_bpp;
    ioctl(fd, FBIOPUT_VSCREENINFO, &var);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
