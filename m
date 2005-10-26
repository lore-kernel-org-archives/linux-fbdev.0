From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/4] fbdev: Remove remaining references to soft_cursor
 from drivers
Date: Wed, 26 Oct 2005 12:59:01 -0700
Message-ID: <20051026125901.61066034.akpm@osdl.org>
References: <435F6DC3.6000802@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUrQE-0000uk-3s
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 12:58:54 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EUrQD-0002ma-UT
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 12:58:54 -0700
In-Reply-To: <435F6DC3.6000802@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Ralf Baechle <ralf@linux-mips.org>

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> au1100fb and au1200fb still refers to soft_cursor. Remove.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
> > drivers/video/Kconfig:1249:warning: 'select' used by config symbol 'FB_AU1200' refer to undefined symbol 'FB_SOFT_CURSOR'
> > 
> > This might be due to a clash-of-intent between some of Tony's stuff and the
> > MIPS tree.   A fix against next -mm would suit, thanks.
> > 
> > 
> 
> Here's the fix
>  
>  Kconfig    |    1 -
>  au1100fb.c |    1 -
>  au1200fb.c |    1 -
>  3 files changed, 3 deletions(-)
> 
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index fcb559b..55ae403 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1246,7 +1246,6 @@ config FB_AU1200
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -	select FB_SOFT_CURSOR
>  	help
>  	  This is the framebuffer driver for the AMD Au1200 SOC.  It can drive
>  	  various panels and CRTs by passing in kernel cmd line option
> diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
> index bf3ac99..a512980 100644
> --- a/drivers/video/au1100fb.c
> +++ b/drivers/video/au1100fb.c
> @@ -424,7 +424,6 @@ static struct fb_ops au1100fb_ops =
>  	.fb_fillrect		= cfb_fillrect,
>  	.fb_copyarea		= cfb_copyarea,
>  	.fb_imageblit		= cfb_imageblit,
> -	.fb_cursor		= soft_cursor,
>  	.fb_rotate		= au1100fb_fb_rotate,
>  	.fb_mmap		= au1100fb_fb_mmap,
>  };
> diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
> index adde4f6..f7243b1 100644
> --- a/drivers/video/au1200fb.c
> +++ b/drivers/video/au1200fb.c
> @@ -1555,7 +1555,6 @@ static struct fb_ops au1200fb_fb_ops =
>  	.fb_fillrect	= cfb_fillrect,
>  	.fb_copyarea	= cfb_copyarea,
>  	.fb_imageblit	= cfb_imageblit,
> -	.fb_cursor		= soft_cursor,
>  	.fb_sync		= NULL,
>  	.fb_ioctl		= au1200fb_ioctl,
>  	.fb_mmap		= au1200fb_fb_mmap,

Well I dunno what to do about this one.  There is no (longer) a au1200fb.c
in my tree and the drivers/video/Kconfig hunk already seems to have been
applied (by Ralf)?

Which leaves us with a single hunk:


From: "Antonino A. Daplas" <adaplas@gmail.com>

au1100fb and au1200fb still refers to soft_cursor. Remove.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/au1100fb.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN drivers/video/au1100fb.c~fbdev-remove-remaining-references-to-soft_cursor-from drivers/video/au1100fb.c
--- 25/drivers/video/au1100fb.c~fbdev-remove-remaining-references-to-soft_cursor-from	Wed Oct 26 12:57:37 2005
+++ 25-akpm/drivers/video/au1100fb.c	Wed Oct 26 12:57:37 2005
@@ -424,7 +424,6 @@ static struct fb_ops au1100fb_ops =
 	.fb_fillrect		= cfb_fillrect,
 	.fb_copyarea		= cfb_copyarea,
 	.fb_imageblit		= cfb_imageblit,
-	.fb_cursor		= soft_cursor,
 	.fb_rotate		= au1100fb_fb_rotate,
 	.fb_mmap		= au1100fb_fb_mmap,
 };
_

Which I guess Ralf should apply.

Ralf, if you're regularly going to be putting framebuffer patches in to the
MIPS tree then we're in for a hard time.


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
