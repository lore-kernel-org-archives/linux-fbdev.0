From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb lockup in .28-rc (bisected)
Date: Tue, 28 Oct 2008 11:05:47 +1100
Message-ID: <1225152347.8004.49.camel@pasglop>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <benh@kernel.crashing.org>) id 1Kuc67-0005XW-96
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Oct 2008 00:06:11 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Kuc5x-0003uS-Q3
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Oct 2008 00:06:11 +0000
In-Reply-To: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Cloos <cloos@jhcloos.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>

On Mon, 2008-10-27 at 19:45 -0400, James Cloos wrote:
> Commit b1ee26bab1 breaks radeonfb on my inspiron 8100 (P3-M with a
> Mobility M7 LW [7500] (1002:4c57 1028:00e6)).
> 
> The boot is OK until init(8) starts; after init outputs its version info
> it calls rc(8), which starts by setting the fb font.  At that point any
> kernel with b1ee26bab1 locks hard.  The cursor stops flashing, magic
> sysrq stops working and the fan starts up after a few seconds.  (I can't
> tell whether it is the CPU or the GPU that heats up.)
> 
> If it is relevant, I use a 10x20 font, so the font change means the
> console converts from 200x75, 8x16 to 160x60, 10x20.

Annoying... Either I'm doing something wrong (which is always possible)
or we're hitting yet another fancy ATI bug (the M7 generation is known
to be pretty bad in that area).

First, let's see if it's related to the imageblit. Can you re-apply the
reverted patch and apply this little hack on top :

Index: linux-work/drivers/video/aty/radeon_accel.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_accel.c	2008-10-28 11:01:49.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_accel.c	2008-10-28 11:01:57.000000000 +1100
@@ -252,6 +252,7 @@ void radeonfb_imageblit(struct fb_info *
 	if (!image->width || !image->height)
 		return;
 
+#if 0
 	/* We only do 1 bpp color expansion for now */
 	if (info->flags & FBINFO_HWACCEL_DISABLED || image->depth != 1)
 		goto fallback;
@@ -275,6 +276,7 @@ void radeonfb_imageblit(struct fb_info *
 	return;
 
  fallback:
+#endif
 	radeon_engine_idle(rinfo);
 
 	cfb_imageblit(info, image);

And let me know if that makes it not lockup.

Cheers,
Ben.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
