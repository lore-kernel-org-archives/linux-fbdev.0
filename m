From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Re: Framebuffer functionality chart (was Re: 
 [Linux-fbdev-users] Projectupdate, new website)
Date: Mon, 30 Aug 2004 22:10:15 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <413389A8.666DCA51@orpatec.ch>
References: <41250552.F3C8E8A9@orpatec.ch> <1092946501.10923.45.camel@atlantis.netenviron.com> <41261949.27CD3CB4@orpatec.ch> <200408212037.31786.adaplas@hotpop.com> <412A276A.1A944B74@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1sTy-0000pg-2J
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 13:10:26 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C1sTw-0004oI-KD
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 13:10:25 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 30 Aug 2004 22:15:20 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

Otto Wyss wrote:
> 
> "Antonino A. Daplas" wrote:
> >
> > On Friday 20 August 2004 23:31, Otto Wyss wrote:
> > > I intend to change the status page into a functionality chart. First I
> > > have to know which functionality exists and are important enough to be
> > > listed. Any imput is welcomed.
> > >
> > Suggestion:
> >
> > A.  Common to all:
> >
> > Hardware:
> > 1. color depths and color visuals supported
> > 2. can the driver pan on the y-axis?
> > 3. can the driver pan on the x-axis?
> > 4. can the hardware state be changed (ie with fbset)?
> > 5. access to framebuffer (fb_read/fb_write/mmap)
> > 6. access to MMIO space
> >
> > Console:
> > 1. can it accelerate imageblit (font drawing)
> > 2. can it accelerate copyarea (block transfers)
> > 3. can it accelerate fillrect (block sets)
> >
> > Video Mode setting:
> > 1. How is the video mode set (more than 1 can be chosen)?
> >         a. at driver load
> >         b. user-specified modelines (ie. fbset)
> >         c. global mode database
> >         d. EDID/private mode database
> >         e. EDID/GTF calculation
> >         f. driver-specific method
> >
> > B. Miscellaneous:
> >         a. support for interrupts on vsync/vblank
> >         b. ioctl for vsync/vblank
> >
Well then is it possible to check all these features with a test
program? Does anyone know how?

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
