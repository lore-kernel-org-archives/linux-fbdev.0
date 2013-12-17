From: Chris Wilson <chris@chris-wilson.co.uk>
Date: Tue, 17 Dec 2013 12:14:35 +0000
Subject: Re: [Intel-gfx] [PATCH 1/2] video/fb: Propagate error code from failing to unregister conflicting fb
Message-Id: <20131217121435.GF22448@nuc-i3427.alporthouse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387209460-9042-1-git-send-email-chris@chris-wilson.co.uk>
	<878uvk3paj.fsf@intel.com>
In-Reply-To: <878uvk3paj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tue, Dec 17, 2013 at 09:33:08AM +0200, Jani Nikula wrote:
> On Mon, 16 Dec 2013, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > If we fail to remove a conflicting fb driver, we need to abort the
> > loading of the second driver to avoid likely kernel panics.
> >
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > ---
> >  drivers/video/fbmem.c | 31 +++++++++++++++++++++----------
> >  include/linux/fb.h    |  4 ++--
> >  2 files changed, 23 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> > index 010d19105ebc..e296967a3abb 100644
> > --- a/drivers/video/fbmem.c
> > +++ b/drivers/video/fbmem.c
> > @@ -1577,10 +1577,10 @@ static bool fb_do_apertures_overlap(struct apertures_struct *gena,
> >  static int do_unregister_framebuffer(struct fb_info *fb_info);
> >  
> >  #define VGA_FB_PHYS 0xA0000
> > -static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
> > -				     const char *name, bool primary)
> > +static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
> > +					      const char *name, bool primary)
> >  {
> > -	int i;
> > +	int i, ret;
> >  
> >  	/* check all firmware fbs and kick off if the base addr overlaps */
> >  	for (i = 0 ; i < FB_MAX; i++) {
> > @@ -1599,22 +1599,29 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
> >  			printk(KERN_INFO "fb: conflicting fb hw usage "
> >  			       "%s vs %s - removing generic driver\n",
> >  			       name, registered_fb[i]->fix.id);
> > -			do_unregister_framebuffer(registered_fb[i]);
> > +			ret = do_unregister_framebuffer(registered_fb[i]);
> > +			if (ret)
> > +				return ret;
> 
> An observation, this bails out early instead of trying to unregister all
> the conflicting framebuffers regardless of errors like before. We're
> probably doomed either way?

Indeed. Early exit hopefully leaves the machine usable for bug reporting.
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
