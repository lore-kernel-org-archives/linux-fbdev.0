From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Re: bugs!
Date: Fri, 14 May 2004 23:12:18 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405142312.18829.lucasvr@gobolinux.org>
References: <200405140130.36852.lucasvr@gobolinux.org> <200405142014.40929.lucasvr@gobolinux.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOoeT-0007xw-Q7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 19:11:49 -0700
Received: from leticia.terra.com.br ([200.154.55.226])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BOoeQ-0003Hf-2e
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 19:11:46 -0700
Received: from rosario.terra.com.br (rosario.terra.com.br [200.154.55.129])
	by leticia.terra.com.br (Postfix) with ESMTP id 9B55B3C12C
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 May 2004 23:11:37 -0300 (BRT)
Received: from ummagumma.ozzmosis.net (200-203-051-117.nhoce7002.dsl.brasiltelecom.net.br [200.203.51.117])
	(authenticated user lucasvr)
	by rosario.terra.com.br (Postfix) with ESMTP id 532263C045
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 May 2004 23:11:37 -0300 (BRT)
In-Reply-To: <200405142014.40929.lucasvr@gobolinux.org>
Content-Disposition: inline
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

Ops, it's the opposite :-)

Lucas


On Friday 14 May 2004 20:14, Lucas Correia Villa Real wrote:
> Hi again,
>
> I've fixed the non-linefetch error: I was passing the virtual framebuffer
> address into fix.smem_start instead of the physical one. Things got weird
> then when fb_writeb() tryied to write on that address ;-)
>
> Cheers,
> Lucas
>
> On Friday 14 May 2004 01:30, Lucas Correia Villa Real wrote:
> > Hi!
> >
> > I'm almost finished with my driver for the monochromatic ST7565 LCD, but
> > I'm dealing with a bug that I could't solve by the entire day.
> >
> > It was designed to be run as a module, and it's living together with
> > another display that already owns the console devices. So, when I load
> > st7565's module, it just skips take_over_console() code in fbmem.c and
> > starts to accept write()'s on it.
> >
> > By the way, I got some demo applications from MicroWindows
> > (microwindows.org) that starts to get more information from the driver.
> > It looks like when they request st7565_set_cmap(), some invalid pointer
> > is accessed and the driver just dies:
> >
> > Unhandled fault: external abort on non-linefetch (0x00a) at 0x4001a004
> > pgd = c3d78000
> > *pgd = 0bcaf001, *pmd = 0bcaf001, *pte = c4a5e0b3, *ppte = c4a5eff2
> >
> > I've looked at other drivers' routines, such as hgafb, and it really
> > looks to be everything on the right place. I got the impression that this
> > error could be happening due to the fact that my driver didn't get the
> > console's ownership, so I've disabled the other driver and compiled
> > st7565 built-in, but then the driver dies with the same message at
> > take_over_console().
> >
> > Does anyone know if hgafb is a working driver that I could rely on? Also
> > I got confused by the need to use or not a color pallete -- probably I
> > don't need, as I'm working only with black/white, but at this time I'm no
> > more sure about anything at all :-)
> >
> > I'm also confused about the "setcolreg()" function passed to
> > fb_get_cmap(). What should it do? What's the meaning of its 1st
> > parameter, "regno"?
> >
> > If someone could take a time to give a quick look on my set_cmap()
> > routine, I've uploaded the code here:
> >
> > http://cscience.org/~lucasvr/etc/st7565.c
> >
> > Thanks in advance, any help will be very appreciated!
> > Lucas
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: SourceForge.net Broadband
> > Sign-up now for SourceForge Broadband and get the fastest
> > 6.0/768 connection for only $19.95/mo for the first 3 months!
> > http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
> > _______________________________________________
> > Linux-fbdev-devel mailing list
> > Linux-fbdev-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: SourceForge.net Broadband
> Sign-up now for SourceForge Broadband and get the fastest
> 6.0/768 connection for only $19.95/mo for the first 3 months!
> http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
