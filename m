From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 2.4.29-pre1] radeonfb: don't try to ioreamp the entire VRAM [was: Re: why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?]
Date: Thu, 2 Dec 2004 05:50:38 +0800
Message-ID: <200412020550.38324.adaplas@hotpop.com>
References: <20041128184606.GA2537@middle.of.nowhere> <Pine.GSO.4.61.0412011724010.26820@waterleaf.sonytel.be> <20041201203711.GA21008@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZcNg-0005bu-6B
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Dec 2004 13:51:24 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CZcNc-0003h5-2D
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Dec 2004 13:51:24 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9B7FBAE6113
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  1 Dec 2004 21:51:04 +0000 (UTC)
In-Reply-To: <20041201203711.GA21008@dreamland.darkstar.lan>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net, Kronos <kronos@people.it>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Thursday 02 December 2004 04:37, Kronos wrote:
> Il Wed, Dec 01, 2004 at 05:25:52PM +0100, Geert Uytterhoeven ha scritto:
> > > Make fb layer aware of the difference between the ioremap()'ed VRAM and
> > > total available VRAM.
> > > smem_len in struct fb_fix_screeninfo still contains the amount of
> > > physical VRAM (reported to userspace via FBIOGET_FSCREENINFO ioctl) and
> > > the new field mapped_vram contains the amount of VRAM actually
> > > ioremap()'ed by drivers (used in read/write/mmap operations).
> > > Since there was unused padding at the end of struct fb_fix_screeninfo
> > > binary compatibility with userspace utilities is retained.
> > > If mapped_vram is not set it's assumed that the entire framebuffer is
> > > mapped, thus other drivers are unaffected by this patch.
> > >
> > > The patch has been tested by Jurriaan <thunder7@xs4all.nl>.
> > >
> > > Signed-off-by: Luca Tettamanti <kronos@people.it>
> > >
> > > --- a/include/linux/fb.h	2004-11-30 18:30:08.000000000 +0100
> > > +++ b/include/linux/fb.h	2004-11-30 18:33:00.000000000 +0100
> > > @@ -126,7 +126,8 @@
> > >  					/* (physical address) */
> > >  	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
> > >  	__u32 accel;			/* Type of acceleration available */
> > > -	__u16 reserved[3];		/* Reserved for future compatibility */
> > > +	__u32 mapped_vram;		/* Amount of ioremap()'ed VRAM */
> > > +	__u16 reserved[1];		/* Reserved for future compatibility */
> > >  };
> >
> > I don't really like this patch. mapped_vram doesn't matter for user space
> > at all, so it does not belong to fb_fix_screeninfo.
>
> Hmm, it looked sensible to me since it's the max amount of data that
> userspace can read (or write) from /dev/fb%d.

Userspace already use fix.line_length * var.yres_virtual to compute the
amount it can access, which is not necessarily equal to the mapped vram.

> Putting mapped_vram in fb_info would be acceptable?

Yes, that is a more sensible solution.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
