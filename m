From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 08 Mar 2012 15:36:32 +0000
Subject: Re: [PATCH] drm: exynos: Fix fb_videomode <-> drm_mode_modeinfo conversion
Message-Id: <20120308153632.GP3852@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331206495-3853-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<4F58AEAE.4080601@samsung.com> <2708446.uONhtK6raB@avalon>
In-Reply-To: <2708446.uONhtK6raB@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Mar 08, 2012 at 04:31:51PM +0100, Laurent Pinchart wrote:
> Hi Joonyoung,
> 
> On Thursday 08 March 2012 22:05:50 Joonyoung Shim wrote:
> > On 03/08/2012 08:34 PM, Laurent Pinchart wrote:
> > > The fb_videomode structure stores the front porch and back porch in the
> > > right_margin and left_margin fields respectively. right_margin should
> > > thus be computed with hsync_start - hdisplay, and left_margin with
> > > htotal - hsync_end. The same holds for the vertical direction.
> > > 
> > >         Active               Front           Sync            Back
> > >         Region               Porch                           Porch
> > > 
> > > <-------------------><----------------><-------------><---------------->
> > > 
> > >    //////////////////|
> > >   
> > >   ////////////////// |
> > > 
> > > //////////////////  |..................               ..................
> > > 
> > >                                         _______________
> > > 
> > > <------ xres -------><- right_margin -><- hsync_len -><- left_margin -->
> > > 
> > > <---- hdisplay ----->
> > > <------------ hsync_start ------------>
> > > <--------------------- hsync_end -------------------->
> > > <--------------------------------- htotal ----------------------------->
> > > 
> > > Fix the fb_videomode<->  drm_mode_modeinfo conversion functions
> > > accordingly.
> > > 
> > > Signed-off-by: Laurent Pinchart<laurent.pinchart@ideasonboard.com>
> > > ---
> > > 
> > >   drivers/gpu/drm/exynos/exynos_drm_connector.c |   16 ++++++++--------
> > >   1 files changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > While trying to understand how the fb_videomode and drm_mode_modeinfo
> > > fields map to each other, I found what might be a bug in the Exynos DRM
> > > driver. Could you please check and confirm that my understanding is
> > > correct ?
> > 
> > Good catch. You can refer Documentation/fb/framebuffer.txt to know in
> > detail.
> > 
> > Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>
> 
> Thank you. There's a similar issue in exynos_mipi_dsi_set_display_mode() where 
> front and back porch are inverted. I'll submit a patch for that as well.

Damned. This seems to be a common misunderstanding. I never really
thought about it and always assumed that 'front porch' and 'back porch'
refers to the picture and not to the sync signal. I was so sure that
I didn't even care to google it before I saw this patch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
