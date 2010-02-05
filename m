From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Fri, 05 Feb 2010 09:28:18 +0000
Subject: Re: [PATCH 2/2] OMAP: DSS2: OMAPFB: implement
Message-Id: <1265362098.17836.169.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1265297486-22438-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1265297486-22438-2-git-send-email-tomi.valkeinen@nokia.com>
	 <20100204230512.GA10145@sci.fi>
In-Reply-To: <20100204230512.GA10145@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ext Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, 2010-02-05 at 00:05 +0100, ext Ville Syrjälä wrote:
> On Thu, Feb 04, 2010 at 05:31:26PM +0200, Tomi Valkeinen wrote:
> > Previously the only place to get the size of the display was from the
> > DSS's sysfs interface, making, for example, configuring overlays and doing
> > updates on manual displays more difficult.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > ---
> >  drivers/video/omap2/omapfb/omapfb-ioctl.c |   18 ++++++++++++++++++
> >  include/linux/omapfb.h                    |    7 +++++++
> >  2 files changed, 25 insertions(+), 0 deletions(-)
> > 
> <snip>
> > @@ -216,6 +217,12 @@ struct omapfb_tearsync_info {
> >  	__u16 reserved2;
> >  };
> >  
> > +struct omapfb_display_info {
> > +	__u16 width;
> > +	__u16 height;
> 
> How about adding the physical display size here as well? I suppose
> mm is the standard unit for such things but for small displays more
> accuracy might be nice.

That can be read from framebuffer's var struct. But I could add it here
also for completeness. Perhaps also some other display related info,
like capabilities.

 Tomi


