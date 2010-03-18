From: Imre Deak <imre.deak@nokia.com>
Date: Thu, 18 Mar 2010 08:52:39 +0000
Subject: Re: [PATCH v3 1/4] DSS2: OMAPFB: Add support for switching memory
Message-Id: <20100318085239.GE30422@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com> <20100317173407.GD30422@localhost> <20100317201425.GI18243@nokia.com>
In-Reply-To: <20100317201425.GI18243@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Mar 17, 2010 at 09:14:25PM +0100, Syrjala Ville (Nokia-D/Helsinki) wrote:
> On Wed, Mar 17, 2010 at 06:34:07PM +0100, Deak Imre (Nokia-D/Helsinki) wrote:
> > Hi,
> > 
> > couple of minor comments inlined.
> > 
> > On Fri, Mar 05, 2010 at 02:26:19PM +0100, Syrjala Ville (Nokia-D/Helsinki) wrote:
> > [...]
> > > @@ -115,30 +184,57 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
> > >         struct omapfb_info *ofbi = FB2OFB(fbi);
> > >         struct omapfb2_device *fbdev = ofbi->fbdev;
> > >         struct omapfb2_mem_region *rg;
> > > -       int r, i;
> > > +       int r = 0;
> > >         size_t size;
> > > +       int i;
> > > 
> > >         if (mi->type > OMAPFB_MEMTYPE_MAX)
> > >                 return -EINVAL;
> > > 
> > >         size = PAGE_ALIGN(mi->size);
> > > 
> > > -       rg = &ofbi->region;
> > > +       rg = ofbi->region;
> > > 
> > > -       for (i = 0; i < ofbi->num_overlays; i++) {
> > > -               if (ofbi->overlays[i]->info.enabled)
> > > -                       return -EBUSY;
> > > +       /* FIXME probably should be a rwsem ... */
> > > +       mutex_lock(&rg->mtx);
> > > +       while (rg->ref) {
> > > +               mutex_unlock(&rg->mtx);
> > > +               schedule();
> > > +               mutex_lock(&rg->mtx);
> > > +       }
> > 
> > Yes, rwsem would mean no unnecessary scheduling and also make things
> > clearer.
> 
> Just tried it and seems to be mostly OK. We get lockdep checking as a
> bonus. It didn't like setup_plane taking the same rwsem twice so I
> added a check to see if the old and new regions are the same and just
> lock once in that case. I thought rwsem was supposed to be OK with
> read recursion but perhaps I was mitaken, or perhaps it's just lockdep
> that's misbehaving.

Ah ok, so it's not so obvious change. Nested read locks could really lead
to a deadlock I think. A read lock will block if there is a write waiter
in the queue to avoid write starvation..

--Imre

