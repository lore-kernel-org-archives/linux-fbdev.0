From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.6.19-rc4-mm2
Date: Wed, 8 Nov 2006 03:01:34 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0611080259340.28657@pademelon.sonytel.be>
References: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A051@EXNA.corp.stratus.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GhclF-0001yS-4Q for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Nov 2006 18:01:53 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GhclC-0000Sk-EM
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Nov 2006 18:01:53 -0800
In-Reply-To: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A051@EXNA.corp.stratus.com>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: ajwade@alumni.uwaterloo.ca, Andrew Morton <akpm@osdl.org>, Kimball Murray <kimball.murray@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Tue, 7 Nov 2006, Richardson, Charlotte wrote:
> If I can't repro it with this chip, if you want to mess around with it
> on yours, here's what I think we had to do... I believe the trick was
> to use 16bpp mode as far as what mode you write to the chip, and then
> double all the x coordinate values for things like offset, width, and
> pitch. You would have to do that to the accelerated routines also.

> > From: Andrew Wade [mailto:andrew.j.wade@gmail.com]
> > On 11/6/06, Richardson, Charlotte <Charlotte.Richardson@stratus.com>
> > wrote:
> > ...
> > > How much is each line offset when you have the garbled stuff? I
> mean,
> > > is it a couple pixels, half the total width, something else? And is
> > > it always the same for each line (or can you tell)?
> > 
> > Each ghost is 1/3 of a screen horizontally from the other ghosts. I've
> > been looking carefully at test patterns to figure out what is going
> on.

Since the ghosts are 1/3 of a screen apart and not 1/2...

If this is similar to the old Mach64, for 24-bit you have to use 8-bit mode and
multiply all horizontal values by _3_.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
