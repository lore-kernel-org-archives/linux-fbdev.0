From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Nov 2012 15:01:41 +0000
Subject: Re: [GIT PULL FOR v3.8] SH Mobile LCDC patches
Message-Id: <1736394.mmzANLCOoi@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1549849.gG4GSCt1EQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <2641878.cGkiV3BMeH@avalon>
In-Reply-To: <2641878.cGkiV3BMeH@avalon>
To: linux-fbdev@vger.kernel.org


--nextPart1549849.gG4GSCt1EQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Thursday 22 November 2012 16:50:35 Tomi Valkeinen wrote:
> On 2012-11-22 16:39, Laurent Pinchart wrote:
> > Hi Tomi,
> > 
> > Thank you for taking care of pull requests for the v3.8 merge window.
> > Here's one already :-)
> > 
> > The following changes since commit
> > f4a75d2eb7b1e2206094b901be09adb31ba63681:
> >   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
> > 
> > are available in the git repository at:
> >   git://linuxtv.org/pinchartl/fbdev.git lcdc-next
> > 
> > Hideki EIRAKU (1):
> >  fbdev: sh_mobile_lcdc: use dma_mmap_coherent
> > 
> > Laurent Pinchart (19):
> >  fbdev: sh_mobile_lcdc: Get display dimensions from the channel structure
> >  fbdev: sh_mobile_lcdc: Rename mode argument to modes
> >  fbdev: sh_mobile_lcdc: Remove priv argument from channel and overlay init
> >  ARM: mach-shmobile: ag5evm: Add LCDC tx_dev field to platform data
> >  fbdev: sh_mipi_dsi: Add channel field to platform data
> >  ARM: mach-shmobile: Initiliaze the new sh_mipi_dsi_info channel field
> >  fbdev: sh_mipi_dsi: Use the sh_mipi_dsi_info channel field
> >  fbdev: sh_mipi_dsi: Use the LCDC entity default mode
> >  fbdev: sh_mipi_dsi: Remove last reference to LCDC platform data
> >  ARM: mach-shmobile: Remove the unused sh_mipi_dsi_info lcd_chan field
> >  fbdev: sh_mipi_dsi: Remove the unused sh_mipi_dsi_info lcd_chan field
> >  fbdev: sh_mobile_lcdc: Store the backlight brightness internally
> >  ARM: mach-shmobile: mackerel: Removed unused get_brightness callback
> >  sh: ap325rxa: Remove unused get_brightness LCDC callback
> >  sh: ecovec24: Remove unused get_brightness LCDC callback
> >  fbdev: sh_mobile_lcdc: Remove unused get_brightness pdata callback
> >  ARM: mach-shmobile: ag5evm: Use the backlight API for brightness control
> >  sh: kfr2r09: Use the backlight API for brightness control
> >  fbdev: sh_mobile_lcdc: Make sh_mobile_lcdc_sys_bus_ops static
> >  
> >  arch/arm/mach-shmobile/board-ag5evm.c       |  198 ++++++++++++----------
> >  arch/arm/mach-shmobile/board-ap4evb.c       |    4 +-
> >  arch/arm/mach-shmobile/board-mackerel.c     |    6 -
> >  arch/sh/boards/mach-ap325rxa/setup.c        |    6 -
> >  arch/sh/boards/mach-ecovec24/setup.c        |    6 -
> >  arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |   16 +--
> >  arch/sh/boards/mach-kfr2r09/setup.c         |    7 +-
> >  arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |    6 +-
> >  drivers/video/sh_mipi_dsi.c                 |   69 ++++------
> >  drivers/video/sh_mobile_lcdcfb.c            |   74 +++++++----
> >  drivers/video/sh_mobile_lcdcfb.h            |    1 +
> >  include/video/sh_mipi_dsi.h                 |    4 +-
> >  include/video/sh_mobile_lcdc.h              |    1 -
> >  13 files changed, 192 insertions(+), 206 deletions(-)
> 
> Well, this does look a bit scary. It's more arch changes than fb
> changes... But all the arch patches seem to be acked by somebody else,
> presumably somebody maintaining the arch stuff, so I guess it's ok if
> these cannot go separately through arm/sh tree.

I forgot to mention that this pull request has been submitted previously, and 
the arch changes can indeed go through fbdev. They need to be interleaved with 
the fbdev changes to avoid bisection breakages.

Sorry for sending you such a scary beast as your first pull request :-)

-- 
Regards,

Laurent Pinchart

--nextPart1549849.gG4GSCt1EQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJQrj5gAAoJEIkPb2GL7hl1mrMH/jDc2TQPcklgWhYlLYJgxC2l
9ugBW0N3675TpQGwtKUzzcKAH8V77OeyQe0in/hvFDEKgvZqdi0+8DDAcVAdEnZT
sKo91RXJq4vy12UpDmcsfmkd/WJxl9xA7yinEL23cVFiGO0ATdMy0d69z4OFl6uU
qLV3CuG6lJJ7fRLLa3bzZCJSeDVKeSJO8eLUIsAzF8/FVgZkx6TXkh0Pg2gCOjU5
8CaBDHat/ejxnAX1/3ev9eg8uMTh3JumzrKwpvkVBtBygoJ44ym5pxd8+r5ue+qQ
Jm5ooqAAzeet9y6QQl1Qots7TbE/5KC4ahn80AqDUxLVHlvlpD/DAtnwjVqIEL0=
=SK7K
-----END PGP SIGNATURE-----

--nextPart1549849.gG4GSCt1EQ--

