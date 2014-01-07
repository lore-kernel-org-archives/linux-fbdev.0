From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 07 Jan 2014 15:15:35 +0000
Subject: Re: [PATCH 13/15] fbdev: sh-mobile-lcdcfb: Enable driver compilation with COMPILE_TEST
Message-Id: <1917257.yB7aZMXWdP@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1542726.dq1lpTml5f@avalon>
In-Reply-To: <1542726.dq1lpTml5f@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 11 December 2013 13:51:18 Laurent Pinchart wrote:
> Hi Jean-Christophe and Tomi,
> 
> Could you please pick this patch up for v3.14 ?

Ping ?

> On Wednesday 27 November 2013 02:18:35 Laurent Pinchart wrote:
> > This helps increasing build testing coverage.
> > 
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > Acked-by: Simon Horman <horms@verge.net.au>
> > ---
> > 
> >  drivers/video/Kconfig | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 4f2e1b3..2aceb08 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -10,7 +10,8 @@ config HAVE_FB_ATMEL
> > 
> >  config SH_MIPI_DSI
> >  	tristate
> > -	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
> > +	depends on HAVE_CLK
> > +	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> > 
> >  config SH_LCD_MIPI_DSI
> >  	bool
> > @@ -1997,7 +1998,8 @@ config FB_W100
> > 
> >  config FB_SH_MOBILE_LCDC
> >  	tristate "SuperH Mobile LCDC framebuffer support"
> > -	depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
> > +	depends on FB && HAVE_CLK
> > +	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> >  	select FB_SYS_FILLRECT
> >  	select FB_SYS_COPYAREA
> >  	select FB_SYS_IMAGEBLIT
> > @@ -2484,7 +2486,7 @@ endif
> > 
> >  config FB_SH_MOBILE_MERAM
> >  	tristate "SuperH Mobile MERAM read ahead support"
> > -	depends on (SUPERH || ARCH_SHMOBILE)
> > +	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> >  	select GENERIC_ALLOCATOR
> >  	---help---
> >  	  Enable MERAM support for the SuperH controller.
-- 
Regards,

Laurent Pinchart

