From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 13 Nov 2015 12:01:04 +0000
Subject: Re: [PATCH 2/2] video:omapdrm: make omapdrm assume the tv-out cable is always connected
Message-Id: <3973104.FPbEEICOqe@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1447410543.git.hns@goldelico.com>
 <5942ddb7ab4f42f207c6c2b54be31a3d9fe3b912.1447410544.git.hns@goldelico.com>
 <5645CD79.5040107@ti.com>
In-Reply-To: <5645CD79.5040107@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, gta04-owner@goldelico.com, linux-omap@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Friday 13 November 2015 13:46:01 Tomi Valkeinen wrote:
> On 13/11/15 12:29, H. Nikolaus Schaller wrote:
> > Include VENC in the set of drivers where it is assimed that the cable
> > is always connected. Like DPI, DSI, DBI and SDI do.
> > 
> > Otherwise, the VENC will return cable status "unknown" and is not enabled
> > by the X-server. So there is no video output signal.
> > 
> > Tested on: BeagleBoard XM, GTA04 and OpenPandora
> > 
> > Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> > ---
> > 
> >  drivers/gpu/drm/omapdrm/omap_connector.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c
> > b/drivers/gpu/drm/omapdrm/omap_connector.c index 83f2a91..98ddb5d 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_connector.c
> > +++ b/drivers/gpu/drm/omapdrm/omap_connector.c
> > @@ -120,6 +120,7 @@ static enum drm_connector_status
> > omap_connector_detect(
> >  		else
> >  			ret = connector_status_disconnected;
> >  	} else if (dssdev->type = OMAP_DISPLAY_TYPE_DPI ||
> > +			dssdev->type = OMAP_DISPLAY_TYPE_VENC ||
> >  			dssdev->type = OMAP_DISPLAY_TYPE_DBI ||
> >  			dssdev->type = OMAP_DISPLAY_TYPE_SDI ||
> >  			dssdev->type = OMAP_DISPLAY_TYPE_DSI) {
> 
> I have no idea why VENC is not working for you when using
> connector_status_unknown, but I just tested DPI with
> connector_status_unknown (i.e. changed the above func to return unknown
> for DPI), and it works fine with X and X omap driver. And xrandr
> confirms that the connection status is unknown:
> 
> # xrandr
> Screen 0: minimum 320 x 200, current 1920 x 1200, maximum 2048 x 2048
> HDMI-1 disconnected (normal left inverted right x axis y axis)
> None-1 unknown connection 1920x1200+0+0 (normal left inverted right x
> axis y axis) 0mm x 0mm
>    1920x1200     60.00*+  60.00 +
> 
> Grep also shows that there are many drivers using
> connector_status_unknown, so I'm guessing it should work fine...

And beside it's not right to consider VENC as always connected, as it isn't. 
The unknown status is there for a reason, to describe connectors for which we 
can't get any status information. The situation is different for DPI, DBI, SDI 
and DSI as those are on-board busses that connect to a non-removable panel, so 
we can say with a good confidence that the panel is connected (the situation 
could be changed with a hammer and a chisel, but that's unlikely to happen, 
hence the confidence).

-- 
Regards,

Laurent Pinchart

