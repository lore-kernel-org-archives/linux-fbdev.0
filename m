From: Kronos <kronos@people.it>
Subject: Re: [PATCH 2.4.29-pre1] radeonfb: don't try to ioreamp the entire VRAM [was: Re: why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?]
Date: Wed, 1 Dec 2004 21:37:12 +0100
Message-ID: <20041201203711.GA21008@dreamland.darkstar.lan>
References: <20041128184606.GA2537@middle.of.nowhere> <20041201161455.GA14817@dreamland.darkstar.lan> <Pine.GSO.4.61.0412011724010.26820@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZbDp-0008R7-UO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Dec 2004 12:37:09 -0800
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CZbDo-0000pC-Pa
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Dec 2004 12:37:09 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0412011724010.26820@waterleaf.sonytel.be>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Il Wed, Dec 01, 2004 at 05:25:52PM +0100, Geert Uytterhoeven ha scritto: 
> > Make fb layer aware of the difference between the ioremap()'ed VRAM and
> > total available VRAM.
> > smem_len in struct fb_fix_screeninfo still contains the amount of
> > physical VRAM (reported to userspace via FBIOGET_FSCREENINFO ioctl) and
> > the new field mapped_vram contains the amount of VRAM actually
> > ioremap()'ed by drivers (used in read/write/mmap operations).
> > Since there was unused padding at the end of struct fb_fix_screeninfo
> > binary compatibility with userspace utilities is retained.
> > If mapped_vram is not set it's assumed that the entire framebuffer is
> > mapped, thus other drivers are unaffected by this patch.
> > 
> > The patch has been tested by Jurriaan <thunder7@xs4all.nl>.
> > 
> > Signed-off-by: Luca Tettamanti <kronos@people.it>
> > 
> > --- a/include/linux/fb.h	2004-11-30 18:30:08.000000000 +0100
> > +++ b/include/linux/fb.h	2004-11-30 18:33:00.000000000 +0100
> > @@ -126,7 +126,8 @@
> >  					/* (physical address) */
> >  	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
> >  	__u32 accel;			/* Type of acceleration available */
> > -	__u16 reserved[3];		/* Reserved for future compatibility */
> > +	__u32 mapped_vram;		/* Amount of ioremap()'ed VRAM */
> > +	__u16 reserved[1];		/* Reserved for future compatibility */
> >  };
> 
> I don't really like this patch. mapped_vram doesn't matter for user space at
> all, so it does not belong to fb_fix_screeninfo.

Hmm, it looked sensible to me since it's the max amount of data that
userspace can read (or write) from /dev/fb%d.
Putting mapped_vram in fb_info would be acceptable?

Luca
-- 
Home: http://kronoz.cjb.net
Carpe diem, quam minimum credula postero. (Q. Horatius Flaccus)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
