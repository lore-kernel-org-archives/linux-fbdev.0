From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 08 Mar 2012 15:31:51 +0000
Subject: Re: [PATCH] drm: exynos: Fix fb_videomode <-> drm_mode_modeinfo conversion
Message-Id: <2708446.uONhtK6raB@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331206495-3853-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<4F58AEAE.4080601@samsung.com>
In-Reply-To: <4F58AEAE.4080601@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Inki Dae <inki.dae@samsung.com>, linux-fbdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, dri-devel@lists.freedesktop.org

Hi Joonyoung,

On Thursday 08 March 2012 22:05:50 Joonyoung Shim wrote:
> On 03/08/2012 08:34 PM, Laurent Pinchart wrote:
> > The fb_videomode structure stores the front porch and back porch in the
> > right_margin and left_margin fields respectively. right_margin should
> > thus be computed with hsync_start - hdisplay, and left_margin with
> > htotal - hsync_end. The same holds for the vertical direction.
> > 
> >         Active               Front           Sync            Back
> >         Region               Porch                           Porch
> > 
> > <-------------------><----------------><-------------><---------------->
> > 
> >    //////////////////|
> >   
> >   ////////////////// |
> > 
> > //////////////////  |..................               ..................
> > 
> >                                         _______________
> > 
> > <------ xres -------><- right_margin -><- hsync_len -><- left_margin -->
> > 
> > <---- hdisplay ----->
> > <------------ hsync_start ------------>
> > <--------------------- hsync_end -------------------->
> > <--------------------------------- htotal ----------------------------->
> > 
> > Fix the fb_videomode<->  drm_mode_modeinfo conversion functions
> > accordingly.
> > 
> > Signed-off-by: Laurent Pinchart<laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >   drivers/gpu/drm/exynos/exynos_drm_connector.c |   16 ++++++++--------
> >   1 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > While trying to understand how the fb_videomode and drm_mode_modeinfo
> > fields map to each other, I found what might be a bug in the Exynos DRM
> > driver. Could you please check and confirm that my understanding is
> > correct ?
> 
> Good catch. You can refer Documentation/fb/framebuffer.txt to know in
> detail.
> 
> Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>

Thank you. There's a similar issue in exynos_mipi_dsi_set_display_mode() where 
front and back porch are inverted. I'll submit a patch for that as well.

-- 
Regards,

Laurent Pinchart

