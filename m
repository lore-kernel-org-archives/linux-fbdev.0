From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 01 Apr 2011 07:07:08 +0000
Subject: Re: [PATCH 1/9] OMAP: DSS2: move dss device clock configuration
Message-Id: <1301641628.3393.5.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
	 <1301566266-11187-2-git-send-email-tomi.valkeinen@ti.com>
	 <4D957923.2030902@ti.com>
In-Reply-To: <4D957923.2030902@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, 2011-04-01 at 12:35 +0530, Archit Taneja wrote:
> On Thursday 31 March 2011 03:40 PM, Valkeinen, Tomi wrote:
> > Clock configuration was defined inside dssdev.phy.dsi struct. The clock
> > config doesn't really belong there, and so it's moved to dssdev.clock
> > struct.
> >
> > Now the explicit clock configuration could also be used for other
> > interfaces than DSI, although there's no support for it currently.
> >
> > Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> > ---
> >   arch/arm/mach-omap2/board-4430sdp.c       |   14 +++++++++-----
> >   arch/arm/plat-omap/include/plat/display.h |   28 ++++++++++++++++------------
> >   drivers/video/omap2/dss/dsi.c             |   14 +++++++-------
> >   3 files changed, 32 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> > index 05288c9..626b16b 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c

<snip>

> > @@ -424,6 +412,22 @@ struct omap_dss_device {
> >   	} phy;
> >
> >   	struct {
> > +		struct {
> > +			u16 lck_div;
> > +			u16 pck_div;
> 
> Is it possible to wrap these members around a channel member? The board 
> file can then fill up the lck_div and ppck_div based on what channel it 
> is using.

Hmm. What do you mean "wrap around"? The channel is defined a bit below
there.

 Tomi


