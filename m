From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Aug 2012 06:07:49 +0000
Subject: Re: [PATCH 00/19] SH Mobile LCDC panel cleanup (including board code)
Message-Id: <20120829060748.GA26931@verge.net.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345122054-16013-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1345122054-16013-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On Mon, Aug 27, 2012 at 05:35:46PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 27 August 2012 17:54:52 Simon Horman wrote:
> > On Thu, Aug 16, 2012 at 03:00:35PM +0200, Laurent Pinchart wrote:
> > > Hi everybody,
> > > 
> > > As part of a general panel API implementation (more on that a bit later),
> > > I've cleaned up panel support in the LCDC driver and in the related board
> > > code. The result is 19 patches independent of the generic panel API that
> > > I would like to get reviewed by the respective board maintainers.
> > 
> > Hi Paul,
> > 
> > I'm happy for you to take all of this, including the mach-shmobile
> > portions through your tree if that works for you.
> 
> I usually push the LCDC patches through the fbdev tree. I'm fine with both 
> options though.

I'm happy for you to handle things in your normal way.

I guess that means that once the LCDC changes are in the fbdev tree
Paul should take the linux-sh changes and I should take the shmobile
changes, is that correct?

> 
> > > Laurent Pinchart (19):
> > >   fbdev: sh_mobile_lcdc: Get display dimensions from the channel
> > >     structure
> > >   fbdev: sh_mobile_lcdc: Rename mode argument to modes
> > >   fbdev: sh_mobile_lcdc: Remove priv argument from channel and overlay
> > >     init
> > >   ARM: mach-shmobile: ag5evm: Add LCDC tx_dev field to platform data
> > >   fbdev: sh_mipi_dsi: Add channel field to platform data
> > >   ARM: mach-shmobile: Initiliaze the new sh_mipi_dsi_info channel field
> > >   fbdev: sh_mipi_dsi: Use the sh_mipi_dsi_info channel field
> > >   fbdev: sh_mipi_dsi: Use the LCDC entity default mode
> > >   fbdev: sh_mipi_dsi: Remove last reference to LCDC platform data
> > >   ARM: mach-shmobile: Remove the unused sh_mipi_dsi_info lcd_chan field
> > >   fbdev: sh_mipi_dsi: Remove the unused sh_mipi_dsi_info lcd_chan field
> > >   fbdev: sh_mobile_lcdc: Store the backlight brightness internally
> > >   ARM: mach-shmobile: mackerel: Removed unused get_brightness callback
> > >   sh: ap325rxa: Remove unused get_brightness LCDC callback
> > >   sh: ecovec24: Remove unused get_brightness LCDC callback
> > >   fbdev: sh_mobile_lcdc: Remove unused get_brightness pdata callback
> > >   ARM: mach-shmobile: ag5evm: Use the backlight API for brightness
> > >     control
> > >   sh: kfr2r09: Use the backlight API for brightness control
> > >   fbdev: sh_mobile_lcdc: Make sh_mobile_lcdc_sys_bus_ops static
> > >  
> > >  arch/arm/mach-shmobile/board-ag5evm.c       |  198 +++++++++++-----------
> > >  arch/arm/mach-shmobile/board-ap4evb.c       |    4 +-
> > >  arch/arm/mach-shmobile/board-mackerel.c     |    6 -
> > >  arch/sh/boards/mach-ap325rxa/setup.c        |    6 -
> > >  arch/sh/boards/mach-ecovec24/setup.c        |    6 -
> > >  arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |   16 +--
> > >  arch/sh/boards/mach-kfr2r09/setup.c         |    7 +-
> > >  arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |    6 +-
> > >  drivers/video/sh_mipi_dsi.c                 |   69 ++++------
> > >  drivers/video/sh_mobile_lcdcfb.c            |   54 ++++----
> > >  drivers/video/sh_mobile_lcdcfb.h            |    1 +
> > >  include/video/sh_mipi_dsi.h                 |    4 +-
> > >  include/video/sh_mobile_lcdc.h              |    1 -
> > >  13 files changed, 172 insertions(+), 206 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
