From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/4] fbdev: Remove remaining references to soft_cursor from drivers
Date: Wed, 26 Oct 2005 21:30:30 +0100
Message-ID: <20051026203030.GA6065@linux-mips.org>
References: <435F6DC3.6000802@gmail.com> <20051026125901.61066034.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUrv6-0002Vm-Sr
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 13:30:48 -0700
Received: from extgw-uk.mips.com ([62.254.210.129] helo=bacchus.net.dhis.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EUrv5-0002E1-BZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 13:30:48 -0700
Content-Disposition: inline
In-Reply-To: <20051026125901.61066034.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

On Wed, Oct 26, 2005 at 12:59:01PM -0700, Andrew Morton wrote:

> > diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
> > index adde4f6..f7243b1 100644
> > --- a/drivers/video/au1200fb.c
> > +++ b/drivers/video/au1200fb.c
> > @@ -1555,7 +1555,6 @@ static struct fb_ops au1200fb_fb_ops =
> >  	.fb_fillrect	= cfb_fillrect,
> >  	.fb_copyarea	= cfb_copyarea,
> >  	.fb_imageblit	= cfb_imageblit,
> > -	.fb_cursor		= soft_cursor,
> >  	.fb_sync		= NULL,
> >  	.fb_ioctl		= au1200fb_ioctl,
> >  	.fb_mmap		= au1200fb_fb_mmap,
> 
> Well I dunno what to do about this one.  There is no (longer) a au1200fb.c
> in my tree and the drivers/video/Kconfig hunk already seems to have been
> applied (by Ralf)?

One or two days ago dropped the whole Au1200 framebuffer patch from my
patchset for Andrew - it was actually only in by accident.

> Which leaves us with a single hunk:
> 
> 
> From: "Antonino A. Daplas" <adaplas@gmail.com>
> 
> au1100fb and au1200fb still refers to soft_cursor. Remove.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/video/au1100fb.c |    1 -
>  1 files changed, 1 deletion(-)
> 
> diff -puN drivers/video/au1100fb.c~fbdev-remove-remaining-references-to-soft_cursor-from drivers/video/au1100fb.c
> --- 25/drivers/video/au1100fb.c~fbdev-remove-remaining-references-to-soft_cursor-from	Wed Oct 26 12:57:37 2005
> +++ 25-akpm/drivers/video/au1100fb.c	Wed Oct 26 12:57:37 2005
> @@ -424,7 +424,6 @@ static struct fb_ops au1100fb_ops =
>  	.fb_fillrect		= cfb_fillrect,
>  	.fb_copyarea		= cfb_copyarea,
>  	.fb_imageblit		= cfb_imageblit,
> -	.fb_cursor		= soft_cursor,
>  	.fb_rotate		= au1100fb_fb_rotate,
>  	.fb_mmap		= au1100fb_fb_mmap,
>  };
> _
> 
> Which I guess Ralf should apply.

Done.

> Ralf, if you're regularly going to be putting framebuffer patches in to the
> MIPS tree then we're in for a hard time.

I had posted that driver before (see below) and not received any feedback ...

  Ralf

From: Ralf Baechle <ralf@linux-mips.org>
Date: Fri, 14 Oct 2005 22:58:42 +0100
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] au1100fb framebuffer fixes
Content-Type: text/plain; charset=us-ascii

For reviewing pleassure.  If nobody objects I'd like to submit this one
as part of my pile of MIPS patches.  The au1100fb driver is the driver
for the AMD Alchemy SOCs.

  Ralf

Author: Pete Popov <ppopov@embeddedalley.com>
Date:   Mon Apr 4 01:06:19 2005 +0000

    Au1100 FB driver uplift for 2.6.



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
