From: "Ambrose, Martin" <martin@ti.com>
Date: Sun, 04 Apr 2010 16:49:49 +0000
Subject: RE: [PATCH v2] DA8XX/OMAP-L1XX: FB: Implement double buffering
Message-Id: <A24693684029E5489D1D202277BE894454789F00@dlee02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <A24693684029E5489D1D202277BE89445316FAB1@dlee02.ent.ti.com>
In-Reply-To: <A24693684029E5489D1D202277BE89445316FAB1@dlee02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Mar 31, 2010 at 20:43:29, Ambrose, Martin wrote:

> Andrew,
> 
> Thanks for the feedback.
> 
> > > +/*
> > > + * Function to wait for vertical sync which for this LCD peripheral
> > > + * translates into waiting for the current raster frame to complete.
> > > + */
> > > +static int fb_wait_for_vsync(struct fb_info *info)
> > > +{
> > > +       struct da8xx_fb_par *par = info->par;
> > > +       wait_queue_t wq;
> > > +       int ret;
> > > +
> > > +       init_waitqueue_entry(&wq, current);
> > 
> > DECLARE_WAITQUEUE() would be more conventional.
> 
> I'll update -- cloned this from some older code I think.

After looking at this further this variable wasn't even used so
I will trim this in upcoming v3 patch.

Regards, 
Martin
