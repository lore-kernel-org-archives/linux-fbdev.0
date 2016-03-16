From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 16 Mar 2016 05:26:58 +0000
Subject: Re: [PATCH 1/2] fbdev: sh_mobile_meram: use ARCH_RENESAS
Message-Id: <1746404.X3VTt1eR6F@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457663298-31973-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1457663298-31973-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Simon,

On Tuesday 15 March 2016 10:25:30 Simon Horman wrote:
> On Fri, Mar 11, 2016 at 09:22:08AM +0200, Laurent Pinchart wrote:
> > On Friday 11 March 2016 09:14:46 Laurent Pinchart wrote:
> > > On Friday 11 March 2016 11:28:17 Simon Horman wrote:
> > > > Use ARCH_RENESAS in place of ARCH_SHMOBILE.
> > > > Also remove spurious ().
> > > > 
> > > > This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> > > > ARCH_RENESAS the motivation for which being that RENESAS seems to be a
> > > > more appropriate name than SHMOBILE for the majority of Renesas ARM
> > > > based SoCs.
> > > > 
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > ---
> > > > 
> > > >  drivers/video/fbdev/Kconfig | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > > > index 8ea45a5cd806..71294f595f61 100644
> > > > --- a/drivers/video/fbdev/Kconfig
> > > > +++ b/drivers/video/fbdev/Kconfig
> > > > @@ -1985,7 +1985,7 @@ config FB_W100
> > > > 
> > > >  config FB_SH_MOBILE_LCDC
> > > >  
> > > >  	tristate "SuperH Mobile LCDC framebuffer support"
> > > > 
> > > > -	depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
> > > > +	depends on FB && (SUPERH || ARCH_RENESAS) && HAVE_CLK
> > > > 
> > > >  	depends on FB_SH_MOBILE_MERAM || !FB_SH_MOBILE_MERAM
> > > >  	select FB_SYS_FILLRECT
> > > >  	select FB_SYS_COPYAREA
> > > > 
> > > > @@ -2450,7 +2450,7 @@ source "drivers/video/fbdev/mmp/Kconfig"
> > > > 
> > > >  config FB_SH_MOBILE_MERAM
> > > >  
> > > >  	tristate "SuperH Mobile MERAM read ahead support"
> > > > 
> > > > -	depends on (SUPERH || ARCH_SHMOBILE)
> > > > +	depends on SUPERH || ARCH_RENESAS
> > > 
> > > The MERAM driver isn't used by any ARM platform, you can just drop
> > > ARCH_SHMOBILE completely.
> > 
> > Actually, upon closer inspection, the MERAM driver isn't used by any
> > platform.
>
> If its not used then I think we should consider removing it.
> 
> However, it seems to me that its used in the following:
> 
> drivers/gpu/drm/shmobile/shmob_drm_crtc.c
> drivers/gpu/drm/shmobile/shmob_drm_kms.c
> drivers/gpu/drm/shmobile/shmob_drm_plane.c
> drivers/video/fbdev/sh_mobile_lcdcfb.c
> 
> It seems to me that we would need to either remove usage in the above
> files or remove the above files before removing the MERAM driver.

That's correct, those drivers need to be fixed or removed.

-- 
Regards,

Laurent Pinchart

