From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 16 Mar 2012 10:23:31 +0000
Subject: Re: [PATCH 2/2] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Message-Id: <1331893411.1653.5.camel@lappy>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331812132-9814-1-git-send-email-cmahapatra@ti.com>
	 <20120315230446.GO17132@sci.fi>
In-Reply-To: <20120315230446.GO17132@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, 2012-03-16 at 01:04 +0200, Ville Syrjälä wrote:
> On Thu, Mar 15, 2012 at 05:18:52PM +0530, Chandrabhanu Mahapatra wrote:
> > In OMAP3 DISPC video overlays suffer from some undocumented horizontal position
> > and timing related limitations leading to SYNCLOST errors. Whenever the image
> > window is moved towards the right of the screen SYNCLOST errors become
> > frequent. Checks have been implemented to see that DISPC driver rejects
> > configuration exceeding above limitations.
> > 
> > This code was successfully tested on OMAP3. This code is written based on code
> > written by Ville Syrjälä <ville.syrjala@nokia.com> in Linux OMAP kernel. Ville
> > Syrjälä <ville.syrjala@nokia.com> had added checks for video overlay horizontal
> > timing and DISPC horizontal blanking length limitations.
> > 
> > Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> > ---
> >  drivers/video/omap2/dss/dispc.c |   67 +++++++++++++++++++++++++++++++++++++--
> >  1 files changed, 64 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> > index 5a1963e..ebfa613 100644
> > --- a/drivers/video/omap2/dss/dispc.c
> > +++ b/drivers/video/omap2/dss/dispc.c
> > @@ -1622,6 +1622,58 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
> >  	}
> >  }
> >  
> > +static int check_horiz_timing(enum omap_channel channel, u16 pos_x,
> > +		u16 width, u16 height, u16 out_width, u16 out_height)
> > +{
> > +	int DS = DIV_ROUND_UP(height, out_height);
> > +	struct omap_dss_device *dssdev = dispc_mgr_get_device(channel);
> > +	struct omap_video_timings t = dssdev->panel.timings;
> > +	int pcd = REG_GET(DISPC_DIVISORo(channel), 7, 0);
> 
> pcd doesn't exist for TV out, which is the reason why you see
> 'lclk/pclk' ratio used instead in the harmattan kernel.

I'm surprised you still remember these things =). And even more
surprised that you actually bothered to review it, thanks for that.

Chandrabhanu, do you have an omap3 board with composite/svideo tv-out?
It'd be good to test on that also, as, like Ville points out, the above
code can't work for tv-out. Hmm, then again, it shouldn't work for HDMI
on OMAP4 either. Did you test with HDMI?

Or is the above code called for TV-manager at all? If not, perhaps it
could be named *_lcd or something. Or perhaps have a BUG_ON(channel !lcd1 or lcd2);

 Tomi


