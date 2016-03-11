From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 11 Mar 2016 07:22:08 +0000
Subject: Re: [PATCH 1/2] fbdev: sh_mobile_meram: use ARCH_RENESAS
Message-Id: <1554589.0Ah0TD31br@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457663298-31973-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1457663298-31973-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Simon,

On Friday 11 March 2016 09:14:46 Laurent Pinchart wrote:
> On Friday 11 March 2016 11:28:17 Simon Horman wrote:
> > Use ARCH_RENESAS in place of ARCH_SHMOBILE.
> > Also remove spurious ().
> > 
> > This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> > ARCH_RENESAS the motivation for which being that RENESAS seems to be a
> > more appropriate name than SHMOBILE for the majority of Renesas ARM based
> > SoCs.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > 
> >  drivers/video/fbdev/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index 8ea45a5cd806..71294f595f61 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -1985,7 +1985,7 @@ config FB_W100
> > 
> >  config FB_SH_MOBILE_LCDC
> >  	tristate "SuperH Mobile LCDC framebuffer support"
> > -	depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
> > +	depends on FB && (SUPERH || ARCH_RENESAS) && HAVE_CLK
> >  	depends on FB_SH_MOBILE_MERAM || !FB_SH_MOBILE_MERAM
> >  	select FB_SYS_FILLRECT
> >  	select FB_SYS_COPYAREA
> > @@ -2450,7 +2450,7 @@ source "drivers/video/fbdev/mmp/Kconfig"
> > 
> >  config FB_SH_MOBILE_MERAM
> >  	tristate "SuperH Mobile MERAM read ahead support"
> > -	depends on (SUPERH || ARCH_SHMOBILE)
> > +	depends on SUPERH || ARCH_RENESAS
> 
> The MERAM driver isn't used by any ARM platform, you can just drop
> ARCH_SHMOBILE completely.

Actually, upon closer inspection, the MERAM driver isn't used by any platform.

> >  	select GENERIC_ALLOCATOR
> >  	---help---
> >  	  Enable MERAM support for the SuperH controller.

-- 
Regards,

Laurent Pinchart

