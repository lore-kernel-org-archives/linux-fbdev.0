From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Framebuffer functionality chart (was Re: [Linux-fbdev-users] Project
 update, new website)
Date: Mon, 23 Aug 2004 19:20:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <412A276A.1A944B74@orpatec.ch>
References: <41250552.F3C8E8A9@orpatec.ch> <1092946501.10923.45.camel@atlantis.netenviron.com> <41261949.27CD3CB4@orpatec.ch> <200408212037.31786.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BzIV3-0000cG-Ls
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Aug 2004 10:20:53 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BzIV2-00033Q-Qp
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Aug 2004 10:20:53 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 23 Aug 2004 19:25:39 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

"Antonino A. Daplas" wrote:
> 
> On Friday 20 August 2004 23:31, Otto Wyss wrote:
> > I intend to change the status page into a functionality chart. First I
> > have to know which functionality exists and are important enough to be
> > listed. Any imput is welcomed.
> >
> Suggestion:
> 
> A.  Common to all:
> 
> Hardware:
> 1. color depths and color visuals supported
> 2. can the driver pan on the y-axis?
> 3. can the driver pan on the x-axis?
> 4. can the hardware state be changed (ie with fbset)?
> 5. access to framebuffer (fb_read/fb_write/mmap)
> 6. access to MMIO space
> 
> Console:
> 1. can it accelerate imageblit (font drawing)
> 2. can it accelerate copyarea (block transfers)
> 3. can it accelerate fillrect (block sets)
> 
> Video Mode setting:
> 1. How is the video mode set (more than 1 can be chosen)?
>         a. at driver load
>         b. user-specified modelines (ie. fbset)
>         c. global mode database
>         d. EDID/private mode database
>         e. EDID/GTF calculation
>         f. driver-specific method
> 
> B. Miscellaneous:
>         a. support for interrupts on vsync/vblank
>         b. ioctl for vsync/vblank
> 
Comments from other developers? Can these points be divided into two
groups ("essential" for minimal functionality and "advanced" for speed
improvements, nice to have features?

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
